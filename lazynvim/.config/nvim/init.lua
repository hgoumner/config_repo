-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_user_command("AirflowView", function()
  require("airflow_log").open()
end, {
  desc = "Open current Airflow log as a column view",
})

vim.api.nvim_create_user_command("AirflowFilter", function(options)
  require("airflow_log").filter(options.args)
end, {
  nargs = 1,
  complete = function()
    return {
      "ALL",
      "DEBUG",
      "INFO",
      "WARN",
      "ERROR",
      "FATAL",
    }
  end,
  desc = "Filter the Airflow column view by level",
})

local airflow_log_group = vim.api.nvim_create_augroup("AirflowLogViewer", {
  clear = true,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = airflow_log_group,
  pattern = "*.log",
  callback = function(args)
    -- Avoid processing special or temporary buffers.
    if vim.bo[args.buf].buftype ~= "" then
      return
    end

    -- Schedule creation of the viewer until Neovim has
    -- completed opening the original log buffer.
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(args.buf) then
        return
      end

      -- Do not open another viewer if the user moved to
      -- a different buffer before the callback executed.
      if vim.api.nvim_get_current_buf() ~= args.buf then
        return
      end

      require("airflow_log").open()
    end)
  end,
  desc = "Automatically open .log files in the Airflow log viewer",
})
