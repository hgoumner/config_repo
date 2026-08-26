vim.api.nvim_set_hl(0, "BGtop", { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "BGmid", { fg = "#00966E" })
vim.api.nvim_set_hl(0, "BGbot", { fg = "#D62612" })

local header = table.concat({
  "██████╗ ██╗   ██╗██╗      ██████╗  █████╗ ██████╗ ██╗ █████╗ ",
  "██╔══██╗██║   ██║██║     ██╔════╝ ██╔══██╗██╔══██╗██║██╔══██╗",
  "██████╔╝██║   ██║██║     ██║  ███╗███████║██████╔╝██║███████║",
  "██╔══██╗██║   ██║██║     ██║   ██║██╔══██║██╔══██╗██║██╔══██║",
  "██████╔╝╚██████╔╝███████╗╚██████╔╝██║  ██║██║  ██║██║██║  ██║",
  "╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝",
}, "\n")

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    dashboard = {
      -- your dashboard configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      width = 70,
      preset = {
        header = header,
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = "<leader>fr" },
          { icon = " ", key = "R", desc = "Recent Files (cwd)", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        }
      },
      formats = {
        header = function(item)
          local lines = vim.split(item.header or "", "\n", { trimempty = true })
          local ret = {}
          for i, line in ipairs(lines) do
            local hl
            if i <= 2 then
              hl = "BGtop"
            elseif i <= 4 then
              hl = "BGmid"
            else
              hl = "BGbot"
            end
            ret[#ret + 1] = { i < #lines and (line .. "\n") or line, hl = hl }
          end
          return ret
        end,
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", limit=10, indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", limits=5,indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    }
  }
}
