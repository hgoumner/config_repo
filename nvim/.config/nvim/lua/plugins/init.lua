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
            vim.cmd('let g:gruvbox_material_background = "hard"')
            vim.cmd('let g:gruvbox_material_better_performance = 1')
            vim.cmd('let g:gruvbox_material_transparent_background = 2')
            vim.cmd('let g:gruvbox_material_current_word = "bold"')
            vim.cmd('let g:gruvbox_material_enable_italic = 1')
            vim.cmd('colorscheme gruvbox-material')
        end,
    },

    -----------------------
    -- Necessary plugins --
    -----------------------

    -------------------------
    -- Basic functionality --
    -------------------------

    -- Navigating
    {
        'kyazdani42/nvim-tree.lua',
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

    -- undotree
    {
        'mbbill/undotree',
        keys = {
            { '<leader>ut', ':UndotreeToggle<CR>', 'Toggle Undotree' },
        }
    },

    -- align objects
    {
        'junegunn/vim-easy-align',
        lazy = false,
    },

    -------------------------
    -- Appearance settings --
    -------------------------

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

    {
       'hiphish/rainbow-delimiters.nvim',
        lazy = false,
    },

    -------------------------------
    -- Language specific plugins --
    -------------------------------

    {
        'chrisbra/csv.vim',
        ft = { 'csv' },
    },

    {
        'imsnif/kdl.vim',
        ft = { 'kdl' },
    },

    -------------------------------
    -- Testing -
    -------------------------------
    {
        'mikesmithgh/kitty-scrollback.nvim',
        enabled = true,
        lazy = true,
        cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
        event = { 'User KittyScrollbackLaunch' },
        -- version = '*', -- latest stable version, may have breaking changes if major version changed
        -- version = '^5.0.0', -- pin major version, include fixes and features that do not have breaking changes
        config = function()
            require('kitty-scrollback').setup()
        end,
    },
}
