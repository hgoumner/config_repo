local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return require('packer').startup(function(use)

    -----------------------
    -- Necessary plugins --
    -----------------------

    use "wbthomason/packer.nvim"                      -- Have packer manage itself
    use "nvim-lua/popup.nvim"                         -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim"                       -- Useful lua functions used ny lots of plugins

    -- Telescope
    use "nvim-telescope/telescope.nvim"               -- Used for multiple features
    -- use 'nvim-telescope/telescope-media-files.nvim'   -- Add on for media files

    -- TreeSitter
    use {                                             -- Powerful parser, required by other plugins
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    -- use "p00f/nvim-ts-rainbow"                     -- Optional addons
    -- use "nvim-treesitter/playground"

    ----------------------
    -- Hristo's plugins --
    ----------------------

    -- Colorscheme and appearance
    -- use "lunarvim/darkplus.nvim"
    -- use 'gruvbox-community/gruvbox'
    use 'sainnhe/gruvbox-material'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- alpha start up
    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }

    --buffer_line
    use 'moll/vim-bbye'
    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = { 'kyazdani42/nvim-web-devicons' }
    }

    -- browser add on
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end 
    }

    -- highlight cursor word
    use 'RRethy/vim-illuminate'

    -- treehopper
    use "mfussenegger/nvim-treehopper"

    -- context vt
    use "haringsrob/nvim_context_vt"

    -- Productivity
    ----------------------------------------------------------------------------------------

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- align code
    use "junegunn/vim-easy-align"

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }

    -- completion
    use "hrsh7th/nvim-cmp"                            -- The completion plugin
    use "hrsh7th/cmp-buffer"                          -- buffer completions
    use "hrsh7th/cmp-path"                            -- path completions
    use "hrsh7th/cmp-cmdline"                         -- cmdline completions
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "saadparwaiz1/cmp_luasnip"                    -- snippet completions

    -- snippets
    use "L3MON4D3/LuaSnip"                            -- snippet engine
    use "rafamadriz/friendly-snippets"                -- a bunch of snippets to use

    -- git
    use "lewis6991/gitsigns.nvim"

    --nvim-tree
    use "kyazdani42/nvim-web-devicons"
    use "kyazdani42/nvim-tree.lua"

    -- terminal
    use "akinsho/toggleterm.nvim"

    -- code structure
    use {
      'stevearc/aerial.nvim',
      config = function() require('aerial').setup() end
    }

    -- undotree
    use "mbbill/undotree"

    -- harpoon
    use 'ThePrimeagen/harpoon'

    -- nvimpeek
    -- use 'gennaro-tedesco/nvim-peekup'

    use {
        "tversteeg/registers.nvim",
        -- config = function()
        --     require("registers").setup()
        -- end,
    }

    use {
         'NvChad/nvim-colorizer.lua',
        --  config = function()
        --     require('colorizer').setup()
        -- end,
    }

    -------------------------------
    -- Language specific plugins --
    -------------------------------

    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-dap-python'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'nvim-telescope/telescope-dap.nvim'
    -- use 'kana/vim-textobj-user'
    -- use 'bps/vim-textobj-python'

    -- python black
    use "averms/black-nvim"
end)
