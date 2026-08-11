local M = {}

local namespace = vim.api.nvim_create_namespace("airflow-log-viewer")

local widths = {
  timestamp = 27,
  level = 9,
  source = 32,
  container = 14,
  logger = 52,
}

-- Strength of the ERROR line background.
--
-- 0.0 means no red tint.
-- 1.0 means the full error color.
--
-- Values between 0.12 and 0.25 usually work well.
local error_background_opacity = 0.18

local valid_levels = {
  TRACE = true,
  DEBUG = true,
  INFO = true,
  WARN = true,
  WARNING = true,
  ERROR = true,
  CRITICAL = true,
  FATAL = true,
}

local timezone_offsets = {
  UTC = "+00:00",
  GMT = "+00:00",

  CET = "+01:00",
  CEST = "+02:00",

  EET = "+02:00",
  EEST = "+03:00",

  WET = "+00:00",
  WEST = "+01:00",

  BST = "+01:00",

  EST = "-05:00",
  EDT = "-04:00",

  CST = "-06:00",
  CDT = "-05:00",

  MST = "-07:00",
  MDT = "-06:00",

  PST = "-08:00",
  PDT = "-07:00",
}

local function trim(value)
  return (value or ""):match("^%s*(.-)%s*$")
end

local function normalize_level(level)
  level = string.upper(trim(level))

  if level == "WARNING" then
    return "WARN"
  end

  if level == "CRITICAL" then
    return "FATAL"
  end

  return level
end

local function is_level(value)
  value = string.upper(trim(value))

  return valid_levels[value] == true
end

local function truncate(value, width)
  value = tostring(value or "")

  if vim.fn.strdisplaywidth(value) <= width then
    return value
  end

  if width <= 1 then
    return vim.fn.strcharpart(value, 0, width)
  end

  return vim.fn.strcharpart(value, 0, width - 1) .. "…"
end

local function pad(value, width)
  value = truncate(value, width)

  local missing = width - vim.fn.strdisplaywidth(value)

  return value .. string.rep(" ", math.max(0, missing))
end

local function integer_to_rgb(color)
  if type(color) ~= "number" then
    return nil
  end

  return {
    red = math.floor(color / 0x10000) % 0x100,
    green = math.floor(color / 0x100) % 0x100,
    blue = color % 0x100,
  }
end

local function rgb_to_hex(color)
  return string.format("#%02x%02x%02x", math.floor(color.red), math.floor(color.green), math.floor(color.blue))
end

local function blend_colors(foreground, background, opacity)
  local foreground_rgb = integer_to_rgb(foreground)

  local background_rgb = integer_to_rgb(background)

  if not foreground_rgb or not background_rgb then
    return nil
  end

  opacity = math.max(0, math.min(1, opacity))

  return rgb_to_hex({
    red = foreground_rgb.red * opacity + background_rgb.red * (1 - opacity),

    green = foreground_rgb.green * opacity + background_rgb.green * (1 - opacity),

    blue = foreground_rgb.blue * opacity + background_rgb.blue * (1 - opacity),
  })
end

local function get_highlight(name)
  local ok, highlight = pcall(vim.api.nvim_get_hl, 0, {
    name = name,
    link = false,
  })

  if ok and type(highlight) == "table" then
    return highlight
  end

  return {}
end

local function get_normal_background()
  local normal = get_highlight("Normal")

  if normal.bg then
    return normal.bg
  end

  if vim.o.background == "light" then
    return 0xffffff
  end

  return 0x1e1e2e
end

local function get_error_color()
  local diagnostic_error = get_highlight("DiagnosticError")

  if diagnostic_error.fg then
    return diagnostic_error.fg
  end

  local error_message = get_highlight("ErrorMsg")

  if error_message.fg then
    return error_message.fg
  end

  return 0xff5f5f
end

local function define_error_line_highlight()
  local background = get_normal_background()

  local error_color = get_error_color()

  local blended = blend_colors(error_color, background, error_background_opacity)

  vim.api.nvim_set_hl(0, "AirflowErrorLine", {
    bg = blended or "#3a2026",
  })
end

local function normalize_numeric_offset(offset)
  offset = trim(offset)

  if offset == "Z" or offset == "z" then
    return "Z"
  end

  if offset:match("^[+-]%d%d:%d%d$") then
    return offset
  end

  local sign, hours, minutes = offset:match("^([+-])(%d%d)(%d%d)$")

  if sign then
    return string.format("%s%s:%s", sign, hours, minutes)
  end

  return nil
end

local function timestamp_to_rfc3339(timestamp)
  timestamp = trim(timestamp)

  local year
  local month
  local day
  local hour
  local minute
  local second
  local fraction
  local timezone
  local numeric_offset

  year, month, day, hour, minute, second, fraction, timezone =
    timestamp:match("^(%d%d%d%d)%-(%d%d)%-(%d%d),%s*" .. "(%d%d):(%d%d):(%d%d)%.(%d+)%s+" .. "([%a]+)$")

  if year then
    local offset = timezone_offsets[string.upper(timezone)]

    if not offset then
      offset = "+00:00"
    end

    return string.format("%s-%s-%sT%s:%s:%s.%s%s", year, month, day, hour, minute, second, fraction, offset)
  end

  year, month, day, hour, minute, second, timezone =
    timestamp:match("^(%d%d%d%d)%-(%d%d)%-(%d%d),%s*" .. "(%d%d):(%d%d):(%d%d)%s+" .. "([%a]+)$")

  if year then
    local offset = timezone_offsets[string.upper(timezone)]

    if not offset then
      offset = "+00:00"
    end

    return string.format("%s-%s-%sT%s:%s:%s%s", year, month, day, hour, minute, second, offset)
  end

  year, month, day, hour, minute, second, numeric_offset =
    timestamp:match("^(%d%d%d%d)%-(%d%d)%-(%d%d),%s*" .. "(%d%d):(%d%d):(%d%d)%s+" .. "([+-]%d%d:?%d%d)$")

  if year then
    local offset = normalize_numeric_offset(numeric_offset)

    if offset then
      return string.format("%s-%s-%sT%s:%s:%s%s", year, month, day, hour, minute, second, offset)
    end
  end

  local date
  local time
  local existing_fraction
  local existing_offset

  date, time, existing_fraction, existing_offset =
    timestamp:match("^(%d%d%d%d%-%d%d%-%d%d)" .. "T(%d%d:%d%d:%d%d)" .. "%.(%d+)" .. "([+-]%d%d:?%d%d)$")

  if date then
    local offset = normalize_numeric_offset(existing_offset)

    if offset then
      return string.format("%sT%s.%s%s", date, time, existing_fraction, offset)
    end
  end

  date, time, existing_offset = timestamp:match("^(%d%d%d%d%-%d%d%-%d%d)" .. "T(%d%d:%d%d:%d%d)" .. "([+-]%d%d:?%d%d)$")

  if date then
    local offset = normalize_numeric_offset(existing_offset)

    if offset then
      return string.format("%sT%s%s", date, time, offset)
    end
  end

  date, time, existing_fraction = timestamp:match("^(%d%d%d%d%-%d%d%-%d%d)" .. "T(%d%d:%d%d:%d%d)" .. "%.(%d+)[Zz]$")

  if date then
    return string.format("%sT%s.%sZ", date, time, existing_fraction)
  end

  date, time = timestamp:match("^(%d%d%d%d%-%d%d%-%d%d)" .. "T(%d%d:%d%d:%d%d)[Zz]$")

  if date then
    return string.format("%sT%sZ", date, time)
  end

  date, time, existing_fraction = timestamp:match("^(%d%d%d%d%-%d%d%-%d%d)" .. "T(%d%d:%d%d:%d%d)" .. "%.(%d+)$")

  if date then
    return string.format("%sT%s.%s", date, time, existing_fraction)
  end

  date, time = timestamp:match("^(%d%d%d%d%-%d%d%-%d%d)" .. "T(%d%d:%d%d:%d%d)$")

  if date then
    return string.format("%sT%s", date, time)
  end

  year, month, day, hour, minute, second = timestamp:match("^(%d%d%d%d)%-(%d%d)%-(%d%d)%s+" .. "(%d%d):(%d%d):(%d%d)$")

  if year then
    return string.format("%s-%s-%sT%s:%s:%s", year, month, day, hour, minute, second)
  end

  return timestamp
end

local function empty_entry(line)
  return {
    timestamp = "",
    rfc3339_timestamp = "",

    level = "",
    outer_level = "",
    application_level = "",

    source = "",
    source_file = "",
    source_line = "",

    container = "",

    logger = "",
    logger_path = "",
    logger_line = "",

    message = line,
    parsed = false,
  }
end

local function parse_outer_level(rest)
  local level, message = rest:match("^(%u+)%s+%-%s+(.*)$")

  if level and is_level(level) then
    return normalize_level(level), message
  end

  return "", rest
end

local function parse_container(rest)
  local container, message = rest:match("^%[([^%]]+)%]%s*(.*)$")

  if container then
    return trim(container), message
  end

  return "", rest
end

local function parse_application_logger(rest)
  local level, logger, message = rest:match("^(%u+):([^:]+):(.*)$")

  if level and is_level(level) then
    return normalize_level(level), trim(logger), message
  end

  return "", "", rest
end

local function python_path_to_logger(path, line)
  path = trim(path)
  line = trim(line)

  local module_path = path

  local site_package_path = path:match("/site%-packages/(.+)$")

  if site_package_path then
    module_path = site_package_path
  else
    local airflow_path = path:match("/(airflow/.+)$")

    if airflow_path then
      module_path = airflow_path
    end
  end

  module_path = module_path:gsub("%.py$", "")

  module_path = module_path:gsub("/", ".")

  module_path = module_path:gsub("^%.+", "")

  if line ~= "" then
    return module_path .. ":" .. line
  end

  return module_path
end

local function parse_python_warning_logger(rest)
  local path, line, message = rest:match("^([^%s]+%.py):(%d+)%s+(.*)$")

  if not path then
    return "", "", "", rest
  end

  local logger = python_path_to_logger(path, line)

  return logger, path, line, message
end

local function parse_line(line)
  local timestamp, source_file, source_line, rest = line:match("^%[([^%]]+)%]%s+" .. "%{([^:}]+):(%d+)%}%s*" .. "(.*)$")

  if not timestamp then
    return empty_entry(line)
  end

  timestamp = trim(timestamp)
  source_file = trim(source_file)
  source_line = trim(source_line)
  rest = trim(rest)

  local outer_level
  outer_level, rest = parse_outer_level(rest)

  local container
  container, rest = parse_container(rest)

  local application_level
  local logger

  application_level, logger, rest = parse_application_logger(rest)

  local logger_path = ""
  local logger_line = ""

  if logger == "" then
    local path_logger
    local path_message

    path_logger, logger_path, logger_line, path_message = parse_python_warning_logger(rest)

    if path_logger ~= "" then
      logger = path_logger
      rest = path_message
    end
  end

  local effective_level = application_level

  if effective_level == "" then
    effective_level = outer_level
  end

  return {
    timestamp = timestamp,

    rfc3339_timestamp = timestamp_to_rfc3339(timestamp),

    level = effective_level,
    outer_level = outer_level,
    application_level = application_level,

    source = source_file .. ":" .. source_line,
    source_file = source_file,
    source_line = source_line,

    container = container,

    logger = logger,
    logger_path = logger_path,
    logger_line = logger_line,

    message = trim(rest),
    parsed = true,
  }
end

local function format_header()
  return table.concat({
    pad("TIMESTAMP", widths.timestamp),
    pad("LEVEL", widths.level),
    pad("SOURCE", widths.source),
    pad("CONTAINER", widths.container),
    pad("LOGGER", widths.logger),
    "MESSAGE",
  }, " ")
end

local function format_row(entry)
  return table.concat({
    pad(entry.rfc3339_timestamp, widths.timestamp),

    pad(entry.level, widths.level),
    pad(entry.source, widths.source),
    pad(entry.container, widths.container),
    pad(entry.logger, widths.logger),

    entry.message,
  }, " ")
end

local function define_highlights()
  vim.api.nvim_set_hl(0, "AirflowHeader", {
    bold = true,
    underline = true,
  })

  vim.api.nvim_set_hl(0, "AirflowTrace", {
    link = "Comment",
  })

  vim.api.nvim_set_hl(0, "AirflowDebug", {
    link = "DiagnosticHint",
  })

  vim.api.nvim_set_hl(0, "AirflowInfo", {
    link = "DiagnosticInfo",
  })

  vim.api.nvim_set_hl(0, "AirflowWarn", {
    link = "DiagnosticWarn",
  })

  vim.api.nvim_set_hl(0, "AirflowError", {
    link = "DiagnosticError",
  })

  vim.api.nvim_set_hl(0, "AirflowFatal", {
    link = "ErrorMsg",
  })

  vim.api.nvim_set_hl(0, "AirflowTime", {
    link = "Number",
  })

  vim.api.nvim_set_hl(0, "AirflowSource", {
    link = "Comment",
  })

  vim.api.nvim_set_hl(0, "AirflowContainer", {
    link = "Identifier",
  })

  vim.api.nvim_set_hl(0, "AirflowLogger", {
    link = "Type",
  })

  vim.api.nvim_set_hl(0, "AirflowUnparsed", {
    link = "WarningMsg",
  })

  define_error_line_highlight()
end

local function level_highlight(level)
  return ({
    TRACE = "AirflowTrace",
    DEBUG = "AirflowDebug",
    INFO = "AirflowInfo",
    WARN = "AirflowWarn",
    ERROR = "AirflowError",
    FATAL = "AirflowFatal",
  })[normalize_level(level)]
end

local function get_column_offsets()
  local timestamp_start = 0

  local level_start = timestamp_start + widths.timestamp + 1

  local source_start = level_start + widths.level + 1

  local container_start = source_start + widths.source + 1

  local logger_start = container_start + widths.container + 1

  local message_start = logger_start + widths.logger + 1

  return {
    timestamp = timestamp_start,
    level = level_start,
    source = source_start,
    container = container_start,
    logger = logger_start,
    message = message_start,
  }
end

local function set_fixed_header()
  define_highlights()

  vim.wo.winbar = "%#AirflowHeader#" .. format_header() .. "%*"
end

local function add_error_line_background(buffer, row, line)
  vim.api.nvim_buf_set_extmark(buffer, namespace, row, 0, {
    end_row = row,
    end_col = #line,
    hl_group = "AirflowErrorLine",
    hl_eol = true,
    hl_mode = "combine",
    priority = 50,
  })
end

local function highlight_buffer(buffer, entries)
  if not vim.api.nvim_buf_is_valid(buffer) then
    return
  end

  vim.api.nvim_buf_clear_namespace(buffer, namespace, 0, -1)

  define_highlights()

  local offsets = get_column_offsets()

  for index, entry in ipairs(entries) do
    local row = index - 1
    local formatted_line = format_row(entry)
    local normalized_level = normalize_level(entry.level)

    if normalized_level == "ERROR" or normalized_level == "FATAL" then
      add_error_line_background(buffer, row, formatted_line)
    end

    vim.api.nvim_buf_add_highlight(
      buffer,
      namespace,
      "AirflowTime",
      row,
      offsets.timestamp,
      offsets.timestamp + widths.timestamp
    )

    local level_group = level_highlight(entry.level)

    if level_group then
      vim.api.nvim_buf_add_highlight(buffer, namespace, level_group, row, offsets.level, offsets.level + widths.level)
    end

    vim.api.nvim_buf_add_highlight(
      buffer,
      namespace,
      "AirflowSource",
      row,
      offsets.source,
      offsets.source + widths.source
    )

    if entry.container ~= "" then
      vim.api.nvim_buf_add_highlight(
        buffer,
        namespace,
        "AirflowContainer",
        row,
        offsets.container,
        offsets.container + widths.container
      )
    end

    if entry.logger ~= "" then
      vim.api.nvim_buf_add_highlight(
        buffer,
        namespace,
        "AirflowLogger",
        row,
        offsets.logger,
        offsets.logger + widths.logger
      )
    end

    if not entry.parsed then
      vim.api.nvim_buf_add_highlight(buffer, namespace, "AirflowUnparsed", row, offsets.message, -1)
    end
  end
end

local function replace_buffer_content(buffer, entries)
  local output = {}

  for _, entry in ipairs(entries) do
    table.insert(output, format_row(entry))
  end

  if #output == 0 then
    output = {
      "",
    }
  end

  vim.bo[buffer].readonly = false
  vim.bo[buffer].modifiable = true

  vim.api.nvim_buf_set_lines(buffer, 0, -1, false, output)

  vim.bo[buffer].modifiable = false
  vim.bo[buffer].readonly = true

  set_fixed_header()
  highlight_buffer(buffer, entries)
end

local function configure_viewer_buffer(buffer, source_name)
  local display_name = vim.fn.fnamemodify(source_name, ":t")

  if display_name == "" then
    display_name = "airflow.log"
  end

  local buffer_name = "Airflow://" .. display_name

  local existing_buffer = vim.fn.bufnr(buffer_name)

  if existing_buffer ~= -1 and existing_buffer ~= buffer then
    buffer_name = buffer_name .. "-" .. tostring(buffer)
  end

  vim.api.nvim_buf_set_name(buffer, buffer_name)

  vim.bo[buffer].buftype = "nofile"
  vim.bo[buffer].bufhidden = "wipe"
  vim.bo[buffer].swapfile = false
  vim.bo[buffer].modifiable = true
  vim.bo[buffer].readonly = false
  vim.bo[buffer].filetype = "airflowlog"

  vim.wo.wrap = false
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.cursorline = true
  vim.wo.list = false
  vim.wo.signcolumn = "no"
  vim.wo.foldenable = false
  vim.wo.spell = false

  set_fixed_header()
end

local function get_current_entries()
  local entries = vim.b.airflow_entries

  if type(entries) ~= "table" then
    return nil
  end

  return entries
end

local function get_displayed_entries()
  local entries = vim.b.airflow_displayed_entries

  if type(entries) ~= "table" then
    return nil
  end

  return entries
end

local function set_displayed_entries(buffer, entries)
  vim.b.airflow_displayed_entries = entries

  replace_buffer_content(buffer, entries)

  if #entries > 0 then
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
  end
end

function M.open()
  local source_buffer = vim.api.nvim_get_current_buf()

  local source_name = vim.api.nvim_buf_get_name(source_buffer)

  local input_lines = vim.api.nvim_buf_get_lines(source_buffer, 0, -1, false)

  local entries = {}

  for _, line in ipairs(input_lines) do
    table.insert(entries, parse_line(line))
  end

  vim.cmd("tabnew")

  local viewer_buffer = vim.api.nvim_get_current_buf()

  configure_viewer_buffer(viewer_buffer, source_name)

  vim.b.airflow_entries = entries

  vim.b.airflow_displayed_entries = entries

  vim.b.airflow_source_buffer = source_buffer

  vim.b.airflow_source_name = source_name

  vim.b.airflow_filter = "ALL"

  replace_buffer_content(viewer_buffer, entries)

  if #entries > 0 then
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
  end
end

function M.filter(level)
  local buffer = vim.api.nvim_get_current_buf()

  local entries = get_current_entries()

  if not entries then
    vim.notify("The current buffer is not an Airflow viewer", vim.log.levels.ERROR)

    return
  end

  level = normalize_level(level)

  if level == "" then
    level = "ALL"
  end

  if level ~= "ALL" and not is_level(level) then
    vim.notify("Unknown Airflow level: " .. level, vim.log.levels.ERROR)

    return
  end

  local filtered = {}

  if level == "ALL" then
    filtered = entries
  else
    for _, entry in ipairs(entries) do
      if normalize_level(entry.level) == level then
        table.insert(filtered, entry)
      end
    end
  end

  vim.b.airflow_filter = level

  set_displayed_entries(buffer, filtered)

  vim.notify(string.format("Airflow filter: %s (%d rows)", level, #filtered), vim.log.levels.INFO)
end

function M.filter_logger(logger_pattern)
  local buffer = vim.api.nvim_get_current_buf()

  local entries = get_current_entries()

  if not entries then
    vim.notify("The current buffer is not an Airflow viewer", vim.log.levels.ERROR)

    return
  end

  logger_pattern = trim(logger_pattern)

  if logger_pattern == "" then
    set_displayed_entries(buffer, entries)

    return
  end

  local filtered = {}

  for _, entry in ipairs(entries) do
    if entry.logger:find(logger_pattern, 1, true) then
      table.insert(filtered, entry)
    end
  end

  set_displayed_entries(buffer, filtered)

  vim.notify(string.format("Airflow logger filter: %s (%d rows)", logger_pattern, #filtered), vim.log.levels.INFO)
end

function M.filter_container(container_name)
  local buffer = vim.api.nvim_get_current_buf()

  local entries = get_current_entries()

  if not entries then
    vim.notify("The current buffer is not an Airflow viewer", vim.log.levels.ERROR)

    return
  end

  container_name = trim(container_name)

  if container_name == "" then
    set_displayed_entries(buffer, entries)

    return
  end

  local filtered = {}

  for _, entry in ipairs(entries) do
    if entry.container == container_name then
      table.insert(filtered, entry)
    end
  end

  set_displayed_entries(buffer, filtered)

  vim.notify(string.format("Airflow container filter: %s (%d rows)", container_name, #filtered), vim.log.levels.INFO)
end

function M.show_details()
  local entries = get_displayed_entries()

  if not entries then
    vim.notify("The current buffer is not an Airflow viewer", vim.log.levels.ERROR)

    return
  end

  local cursor = vim.api.nvim_win_get_cursor(0)

  local entry_index = cursor[1]

  local entry = entries[entry_index]

  if not entry then
    return
  end

  local details = {
    "Original timestamp: " .. entry.timestamp,

    "RFC3339 timestamp:  " .. entry.rfc3339_timestamp,

    "Displayed level:   " .. entry.level,

    "Airflow level:     " .. entry.outer_level,

    "Application level: " .. entry.application_level,

    "Source file:       " .. entry.source_file,

    "Source line:       " .. entry.source_line,

    "Container:         " .. entry.container,

    "Logger:            " .. entry.logger,

    "Logger path:       " .. entry.logger_path,

    "Logger line:       " .. entry.logger_line,

    "",
    "Message:",
    entry.message,
  }

  vim.notify(table.concat(details, "\n"), vim.log.levels.INFO)
end

function M.refresh()
  local viewer_buffer = vim.api.nvim_get_current_buf()

  local source_buffer = vim.b.airflow_source_buffer

  if type(source_buffer) ~= "number" or not vim.api.nvim_buf_is_valid(source_buffer) then
    vim.notify("The original Airflow log buffer is unavailable", vim.log.levels.ERROR)

    return
  end

  local input_lines = vim.api.nvim_buf_get_lines(source_buffer, 0, -1, false)

  local entries = {}

  for _, line in ipairs(input_lines) do
    table.insert(entries, parse_line(line))
  end

  vim.b.airflow_entries = entries
  vim.b.airflow_filter = "ALL"

  set_displayed_entries(viewer_buffer, entries)

  vim.notify(string.format("Airflow view refreshed: %d rows", #entries), vim.log.levels.INFO)
end

function M.setup_buffer_keymaps()
  local buffer = vim.api.nvim_get_current_buf()

  vim.keymap.set("n", "<CR>", function()
    M.show_details()
  end, {
    buffer = buffer,
    silent = true,
    desc = "Show Airflow log details",
  })

  vim.keymap.set("n", "R", function()
    M.refresh()
  end, {
    buffer = buffer,
    silent = true,
    desc = "Refresh Airflow log view",
  })

  vim.keymap.set("n", "0", function()
    M.filter("ALL")
  end, {
    buffer = buffer,
    silent = true,
    desc = "Clear Airflow level filter",
  })

  vim.keymap.set("n", "1", function()
    M.filter("DEBUG")
  end, {
    buffer = buffer,
    silent = true,
    desc = "Filter Airflow DEBUG logs",
  })

  vim.keymap.set("n", "2", function()
    M.filter("INFO")
  end, {
    buffer = buffer,
    silent = true,
    desc = "Filter Airflow INFO logs",
  })

  vim.keymap.set("n", "3", function()
    M.filter("WARN")
  end, {
    buffer = buffer,
    silent = true,
    desc = "Filter Airflow WARN logs",
  })

  vim.keymap.set("n", "4", function()
    M.filter("ERROR")
  end, {
    buffer = buffer,
    silent = true,
    desc = "Filter Airflow ERROR logs",
  })

  vim.keymap.set("n", "5", function()
    M.filter("FATAL")
  end, {
    buffer = buffer,
    silent = true,
    desc = "Filter Airflow FATAL logs",
  })
end

local original_open = M.open

M.open = function()
  original_open()
  M.setup_buffer_keymaps()
end

M.parse_line = parse_line

M.timestamp_to_rfc3339 = timestamp_to_rfc3339

return M
