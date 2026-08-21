return {
  "saghen/blink.cmp",
  opts = {
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "copilot" }, -- Add "copilot" to the default list
      providers = {
        copilot = {
          name = "copilot",
        },
      },
    },
    -- Ensure keymaps for accepting suggestions work
    keymap = {
      ["<Tab>"] = { "select_and_accept", "fallback" },
      ["<S-Tab>"] = { "select_and_accept", "fallback" },
    },
  },
}
