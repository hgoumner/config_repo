return {
    --------------------------
    -- Colorscheme settings --
    --------------------------

    {
        'sainnhe/gruvbox-material',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd('set background=dark')
            vim.cmd('let g:gruvbox_material_background = "soft"')
            vim.cmd('let g:gruvbox_material_better_performance = 1')
            vim.cmd('let g:gruvbox_material_transparent_background = 2')
            vim.cmd('let g:gruvbox_material_current_word = "bold"')
            vim.cmd('colorscheme gruvbox-material')
        end,
    },

    -----------------------
    -- Necessary plugins --
    -----------------------

    -- An implementation of the Popup API from vim in Neovim
    -- 'nvim-lua/popup.nvim',

    -- TreeSitter for parsing
    -- {
    --     'nvim-treesitter/nvim-treesitter',
    --     build = ':TSUpdate',
    --     lazy = false,
    -- },
    -- {
    --     'nvim-treesitter/nvim-treesitter-textobjects',
    --     lazy = false,
    -- },

    -------------------------
    -- Basic functionality --
    -------------------------

    -- Navigating
    {
        'kyazdani42/nvim-tree.lua',
        -- lazy = false,
        dependencies = {
            'kyazdani42/nvim-web-devicons'
        },
        keys = {
            { '<leader>e', '<CMD>NvimTreeToggle<CR>', desc = 'Toggle NVIM Tree' }
        },
        config = function()
            require('nvim-tree').setup()
        end,
    },

    -- Searching
    -- {
    --     'nvim-telescope/telescope.nvim',
    --     lazy = false,
    --     dependencies = {
    --         -- Useful lua functions used ny lots of plugins
    --         'nvim-lua/plenary.nvim'
    --     }
    -- },

    -- Commenting
    {
        'numToStr/Comment.nvim',
        lazy = false,
        config = function()
            require('Comment').setup()
        end
    },

    -- Formatting
    -- Surround words, etc
    {
        'kylechui/nvim-surround',
        lazy = false,
        config = function()
            require('nvim-surround').setup()
        end,
    },

    -- Registers and marks
    {
        'tversteeg/registers.nvim',
        lazy = false,
        config = function()
            require('registers').setup()
        end,
    },
    {
        'ThePrimeagen/harpoon',
        -- lazy = false,
        config = function()
            require('harpoon').setup()
        end,
        keys = {
            { '<leader>hm', ':lua require("harpoon.mark").add_file()<CR>', 'Add file to harpoon list' },
            { '<leader>hu', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', 'Show harpoon list' },
        },
    },

    -- git
    {
        'lewis6991/gitsigns.nvim',
        lazy = false,
        config = function()
            require('gitsigns').setup()
        end,
    },

    -- color colors
    -- {
    --     'NvChad/nvim-colorizer.lua',
    --     lazy = false,
    -- },

    -- -- LSP
    -- {
    --     'VonHeikemen/lsp-zero.nvim',
    --     lazy = false,
    --     dependencies = {
    --         -- LSP Support
    --         'neovim/nvim-lspconfig',
    --         'williamboman/mason.nvim',
    --         'williamboman/mason-lspconfig.nvim',
    --
    --         -- Autocompletion
    --         'hrsh7th/nvim-cmp',
    --         'hrsh7th/cmp-buffer',
    --         'hrsh7th/cmp-path',
    --         'saadparwaiz1/cmp_luasnip',
    --         'hrsh7th/cmp-nvim-lsp',
    --         'hrsh7th/cmp-nvim-lua',
    --     },
    -- },

    -- undotree
    {
        'mbbill/undotree',
        keys = {
            { '<leader>ut', ':UndotreeToggle<CR>', 'Toggle Undotree' },
        }
    },

    -- code structure
    {
        'stevearc/aerial.nvim',
        config = function()
            require('aerial').setup()
        end,
        keys = {
            { '<leader>a', '<cmd>AerialToggle<CR>', 'Toggle aerial panel' },
        },
    },

    -- terminal
    -- {
    --     'akinsho/toggleterm.nvim',
    --     config = function()
    --         require('toggleterm').setup()
    --     end,
    --     keys = {
    --         { '<C-\\>', '<CMD>ToggleTerm size=20 direction=float<CR>', 'Toggle terminal' },
    --     },
    -- },

    -- align objects
    {
        'junegunn/vim-easy-align',
        lazy = false,
    },

    -------------------------
    -- Appearance settings --
    -------------------------

    -- -- alpha start up
    -- {
    --     'goolord/alpha-nvim',
    --     lazy = false,
    --     dependencies = { 'kyazdani42/nvim-web-devicons' },
    --     config = function()
    --         require('alpha').setup(require('alpha.themes.theta').config)
    --     end,
    -- },

    -- {
    --     'nvim-lualine/lualine.nvim',
    --     lazy = false,
    --     dependencies = { 'kyazdani42/nvim-web-devicons' },
    --     config = function()
    --         require('lualine').setup()
    --     end,
    -- },

    --buffer_line
    {
        'akinsho/bufferline.nvim',
        lazy = false,
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require('bufferline').setup({
                options = {
                    separator_style = 'slant',
                }
            })
        end,
    },

    -- highlight cursor word
    {
        'RRethy/vim-illuminate',
        lazy = false,
        -- config = function()
        --     require('vim-illuminate').setup()
        -- end,
    },

    -- context vt
    -- {
    --     'haringsrob/nvim_context_vt',
    --     lazy = false,
    --     -- config = function()
    --     --     require('nvim_context_vt').setup()
    --     -- end,
    -- },

    -------------------------------
    -- Language specific plugins --
    -------------------------------

    -- {
    --     'mfussenegger/nvim-dap',
    --     'rcarriga/nvim-dap-ui',
    --     'theHamsta/nvim-dap-virtual-text',
    --     'nvim-telescope/telescope-dap.nvim',
    --
    --     --language specific
    --     'mfussenegger/nvim-dap-python',
    -- },

    -- python black
    {
        'averms/black-nvim',
        ft = { 'python' },
    },

    {
        'cjrh/vim-conda',
        ft = { 'python' },
    },

    -------------------------------
    -- Testing -
    -------------------------------

    {
        'mg979/vim-visual-multi',
        lazy = false,
    },

    {
        'chrisbra/csv.vim',
        ft = { 'csv' },
    },

    {
        'ziontee113/icon-picker.nvim',
        lazy = false,
        config = function()
            require("icon-picker").setup({
                disable_legacy_commands = true
            })
        end
    },

    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
}

-- -------------------
-- -- Miscellaneous --
-- -------------------
-- -- treehopper
-- 'mfussenegger/nvim-treehopper'
