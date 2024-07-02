return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewfile' },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
    },
    config = function ()

        local lspconfig = require('lspconfig')

        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        local keymap = vim.keymap

        local opts = { noremap = true, silent = true }
        local on_attach = function (client, bufnr)
            opts.buffer = bufnr

            opts.desc = 'LSP references'
            keymap.set('n', 'gR', '<CMD>Telescope lsp_references<CR>', opts)

            opts.desc = "Go to declaration"
            keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

            opts.desc = "Show LSP definitions"
            keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

            opts.desc = "Show LSP implementations"
            keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

            opts.desc = "Show LSP type definitions"
            keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

            opts.desc = "See available code actions"
            keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

            opts.desc = "Show buffer diagnostics"
            keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

            opts.desc = "Show line diagnostics"
            keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

            opts.desc = "Go to previous diagnostic"
            keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

            opts.desc = "Go to next diagnostic"
            keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

            opts.desc = "Restart LSP"
            keymap.set("n", "<leader>rs", "<CMD>LspRestart<CR>", opts) -- mapping to restart lsp if necessary
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Change the Diagnostic symbols in the sign column (gutter)
        -- (not in youtube nvim video)
        local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }
        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        lspconfig["pylsp"].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = {
                            ignore = {
                                'E402',
                                'W391'
                            },
                            maxLineLength = 120
                        },
                        ruff = {
                            enabled = true,  -- Enable the plugin
                            formatEnabled = true,  -- Enable formatting using ruffs formatter
                            executable = "/usr/local/bin/ruff",  -- Custom path to ruff
                            config = "/home/hristo/pipeline/ruff.toml",  -- Custom config for ruff to use
                            extendSelect = { "I" },  -- Rules that are additionally used by ruff
                            extendIgnore = { "C90" },  -- Rules that are additionally ignored by ruff
                            format = { "I" },  -- Rules that are marked as fixable by ruff that should be fixed when running textDocument/formatting
                            severities = { ["D212"] = "I" },  -- Optional table of rules where a custom severity is desired
                            unsafeFixes = false,  -- Whether or not to offer unsafe fixes as code actions. Ignored with the "Fix All" action

                            -- Rules that are ignored when a pyproject.toml or ruff.toml is present:
                            lineLength = 120,  -- Line length to pass to ruff checking and formatting
                            exclude = { "__about__.py" },  -- Files to be excluded by ruff checking
                            select = { "F" },  -- Rules to be enabled by ruff
                            ignore = {
                                'E402',
                                'W391',
                                "D210"
                            },  -- Rules to be ignored by ruff
                            perFileIgnores = { ["__init__.py"] = "CPY001" },  -- Rules that should be ignored for specific files
                            preview = true,  -- Whether to enable the preview style linting and formatting.
                            targetVersion = "py310",  -- The minimum python version to target (applies for both linting and formatting).
                        },
                    }
                }
            }
        }

        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = { -- custom settings for lua
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

    end,
}
