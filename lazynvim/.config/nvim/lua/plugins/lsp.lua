return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              typeCheckingMode = "strict",
              analysis = {
                autoImportCompletions = true,
                disableOrganizeImports = true,
              },
            },
            python = {
              pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
            },
          },
        },
        ruff = {
          init_options = {
            settings = {
              fixAll = true,
              organizeImports = true,
              logLevel = "error",
            },
          },
        },
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

  -- Disable prettier/eslint for the filetypes biome covers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = { enabled = false },
      },
    },
  },
}
