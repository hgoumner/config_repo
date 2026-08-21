return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = { enabled = true },
    panel = { enabled = true },
    filetypes = {
      -- Ensure you aren't disabling it for the filetypes you use
      yaml = false,
      markdown = false,
    },
  },
}
