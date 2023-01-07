-- neovim settings
require('user.options')
require('user.keymaps')
require('user.plugins')

vim.api.nvim_command('highlight CursorLine ctermbg=none guibg=none')
vim.api.nvim_command('highlight LineNrAbove guifg=white')
vim.api.nvim_command('highlight CursorLineNr guifg=green guibg=none')
vim.api.nvim_command('highlight LineNrBelow guifg=red')

vim.g.python3_host_prog = '~/.local/venv/nvim/bin/python'
