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
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)

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
  use 'gruvbox-community/gruvbox'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
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

  -- Productivity
  ----------------------------------------------------------------------------------------

  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
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

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
