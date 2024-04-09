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

    -- highlight cursor word
    {
        'azabiong/vim-highlighter',
        lazy = false,
        config = function ()
            vim.cmd([[
                " default key mappings
                " let HiSet   = 'f<CR>'
                " let HiErase = 'f<BS>'
                " let HiClear = 'f<C-L>'
                " let HiFind  = 'f<Tab>'
                " let HiSetSL = 't<CR>'

                " jump key mappings
                nn <CR>     <Cmd>Hi><CR>
                nn g<CR>    <Cmd>Hi<<CR>
                nn [<CR>    <Cmd>Hi{<CR>
                nn ]<CR>    <Cmd>Hi}<CR>

                " find key mappings
                nn -        <Cmd>Hi/next<CR>
                nn _        <Cmd>Hi/previous<CR>
                nn f<Left>  <Cmd>Hi/older<CR>
                nn f<Right> <Cmd>Hi/newer<CR>

                " directory to store highlight files
                " let HiKeywords = '~/.vim/after/vim-highlighter'
            ]])
        end,
    },
    -- {
    --     'RRethy/vim-illuminate',
    --     lazy = false,
    --     config = function()
    --         require('illuminate').configure({
    --             providers = {
    --                 'lsp',
    --                 'treesitter',
    --                 'regex'
    --             },
    --             under_cursor = true,
    --             case_insensitive_regex = true,
    --         })
    --     end,
    -- },

    -------------------------------
    -- Language specific plugins --
    -------------------------------

    {
        'chrisbra/csv.vim',
        ft = { 'csv' },
    },

    -------------------------------
    -- Testing -
    -------------------------------

    {
       'hiphish/rainbow-delimiters.nvim',
        lazy = false,
    },

    {
        'rcarriga/nvim-notify',
        lazy = false,
        config = function()

            vim.opt.termguicolors = true

            require("notify").setup {
                background_colour = "#000000",
            }
        end,
    },

    {
        "lukoshkin/highlight-whitespace",
        lazy = false,
        -- config=true,
        opts = {
            tws = "\\s\\+$",
            clear_on_winleave = false,
            palette = {
                markdown = {
                    tws = 'RosyBrown',
                    ['\\S\\@<=\\s\\(\\.\\|,\\)\\@='] = 'CadetBlue3',
                    ['\\S\\@<= \\{2,\\}\\S\\@='] = 'SkyBlue1',
                    ['\\t\\+'] = 'plum4',
                },
                other = {
                    -- tws = 'PaleVioletRed',
                    tws = 'Red',
                    ['\\S\\@<=\\s,\\@='] = 'coral1',
                    ['\\S\\@<=\\(#\\|--\\)\\@<! \\{2,3\\}\\S\\@=\\(#\\|--\\)\\@!'] = 'LightGoldenrod3',
                    ['\\(#\\|--\\)\\@<= \\{2,\\}\\S\\@='] = '#3B3B3B',
                    ['\\S\\@<= \\{3,\\}\\(#\\|--\\)\\@='] = '#3B3B3B',
                    ['\\t\\+'] = 'plum4',
                }
            }
  }
    },
}
