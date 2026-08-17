return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          mason = false,
          cmd = { vim.fn.exepath("basedpyright-langserver"), "--stdio" },
        },
        ruff = {
          mason = false,
          cmd = { vim.fn.exepath("ruff"), "server" },
          init_options = {
            settings = {
              fixAll = true,
              organizeImports = true,
              logLevel = "error",
            },
          },
        },
        eslint = { enabled = false },
      },
    },
  },

  -- Formatting via conform
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "biome" },
        javascriptreact = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
      },
    },
  },
}
