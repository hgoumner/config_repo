-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- -- Choose your type checker: "pyright" | "basedpyright"
vim.g.lazyvim_python_lsp = "basedpyright"

-- Use the native ruff server (not the deprecated ruff_lsp)
vim.g.lazyvim_python_ruff = "ruff"
