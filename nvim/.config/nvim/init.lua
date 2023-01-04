-- neovim settings
require("user.options")
require("user.keymaps")
require("user.plugins")

-- colorscheme
require("plugins.colorscheme")

-- plugin settings
require("plugins.aerial")
require("plugins.alpha")
require("plugins.bufferline")
require("plugins.cmp")
require("plugins.colorizer")
require("plugins.comment")
require("plugins.gitsigns")
require("plugins.harpoon")
require("plugins.lspzero")
require("plugins.lualine")
require("plugins.nvim-context-vt")
require("plugins.nvim-dap")
require("plugins.nvim-tree")
require("plugins.registers")
require("plugins.telescope")
require("plugins.toggleterm")
require("plugins.treesitter")
require("plugins.vim-illuminate")

vim.g.python3_host_prog = '~/.local/venv/nvim/bin/python'
