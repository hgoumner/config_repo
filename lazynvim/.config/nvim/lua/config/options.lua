-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- -- Choose your type checker: "pyright" | "basedpyright"
vim.g.lazyvim_python_lsp = "basedpyright"

-- Use the native ruff server (not the deprecated ruff_lsp)
vim.g.lazyvim_python_ruff = "ruff"

vim.g.clipboard = "osc52"
vim.opt.clipboard = "unnamedplus"

-- disable auto-format on save
vim.g.autoformat = false -- globally
vim.b.autoformat = false -- buffer-local

vim.diagnostic.config({
  virtual_text = {
    -- Change format if you want to keep standard spacing
    spacing = 4,
    source = "if_many", -- Only shows the source name if multiple sources exist
    -- Custom function to dynamic generate the prefix based on diagnostic data
    prefix = function(diagnostic)
      -- Check if a source (ruff, pylint, etc.) exists
      if diagnostic.source then
        return string.format("● [%s] ", diagnostic.source)
      end
      return "● "
    end,
  },
})
