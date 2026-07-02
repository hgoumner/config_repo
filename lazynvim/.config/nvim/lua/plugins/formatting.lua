return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = {
          "ruff_fix", -- auto-fix lint errors
          "ruff_organize_imports", -- sort imports
          "ruff_format", -- format
        },
      },
      format_on_save = {
        timeout_ms = 3000,
        lsp_fallback = false, -- don't fall back to LSP formatter
      },
    },
  },
}
