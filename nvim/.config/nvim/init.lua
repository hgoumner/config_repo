-- neovim settings
require('user.options')
require('user.keymaps')
require('user.plugins')

vim.api.nvim_set_hl(0, 'CursorLine', {fg='', bg=''})
vim.api.nvim_set_hl(0, 'LineNrAbove', {fg='white', bg=''})
vim.api.nvim_set_hl(0, 'CursorLineNr', {fg='green', bg=''})
vim.api.nvim_set_hl(0, 'LineNrBelow', {fg='red', bg=''})

vim.g.python3_host_prog = '~/.local/venv/nvim/bin/python'
