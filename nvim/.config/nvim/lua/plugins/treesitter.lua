return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = false,
        config = function()

            local configs = require('nvim-treesitter.configs')

            configs.setup {
                -- ensure_installed = { 'c', 'cpp', 'lua', 'python', 'bash', 'help', 'latex', 'julia' },
                ensure_installed = { 'c', 'cpp', 'lua', 'python', 'rust', 'bash' },
                sync_install = false,
                ignore_install = { "" }, -- list of parsers to ignore installing
                highlight = {
                    enable = true, -- false will disable the whole extension
                    disable = { "" }, -- list of language that will be disabled
                    additional_vim_regex_highlighting = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = 'gnn',
                        node_incremental = 'grn',
                        scope_incremental = 'grc',
                        node_decremental = 'grm',
                    },
                },
                indent = {
                    enable = true,
                    disable = { "yaml" }
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- you can use the capture groups defined in textobjects.scm
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']m'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[m'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                },
            }
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        lazy = false,
    },
    {
        'nvim-treesitter/nvim-treesitter-refactor',
        lazy = false,
        config = function()

            require('nvim-treesitter.configs').setup {
                refactor = {
                    highlight_definitions = {
                        enable = true,
                        -- Set to false if you have an `updatetime` of ~100.
                        clear_on_cursor_move = true,
                    },
                    smart_rename = {
                        enable = true,
                        keymaps = {
                            smart_rename = 'grr',
                        },
                    },
                },
            }
        end,
    },
}
