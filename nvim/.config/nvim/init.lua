-- neovim settings
require("user.options")
require("user.keymaps")
require("user.plugins")

-- plugin settings
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.colorscheme")
require("plugins.alpha")
require("plugins.lualine")
require("plugins.bufferline")
require("plugins.comment")
require("plugins.cmp")
require("plugins.gitsigns")
require("plugins.nvim-tree")
require("plugins.toggleterm")
require("plugins.nvim-dap")
require("plugins.lspzero")
require("plugins.nvim-context-vt")
require("plugins.aerial")
require("plugins.harpoon")
require("plugins.registers")
require("plugins.colorizer")
require("plugins.vim-illuminate")

vim.cmd [[
    let g:python3_host_prog = $HOME . '/.local/venv/nvim/bin/python'
]]
