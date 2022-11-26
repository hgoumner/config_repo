require("user.keymaps")
require("user.plugins")
require("user.telescope")
require("user.treesitter")
require("user.colorscheme")
require("user.alpha")
require("user.lualine")
require("user.bufferline")
require("user.comment")
require("user.cmp")
require("user.gitsigns")
require("user.nvim-tree")
require("user.toggleterm")
require("user.options")
require("user.nvim-dap")
require("user.lspzero")
require("user.vim-illuminate")
require("user.nvim-context-vt")
require("user.aerial")

vim.cmd [[
    let g:python3_host_prog = $HOME . '/.local/venv/nvim/bin/python'
]]
