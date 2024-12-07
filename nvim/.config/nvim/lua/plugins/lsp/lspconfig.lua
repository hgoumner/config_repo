return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewfile' },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        { 'antosha417/nvim-lsp-file-operations', config = true },
    },
    config = function()
        local lspconfig = require('lspconfig')

        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        local keymap = vim.keymap

        local opts = { noremap = true, silent = true }

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })

        local on_attach = function(client, bufnr)
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

        -- Configure `ruff-lsp`.
        -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
        -- -- For the default config, along with instructions on how to customize the settings
        lspconfig["ruff"].setup {
            trace = "messages",
            init_options = {
                settings = {
                    configuration = "~/.config/ruff/ruff.toml",
                    configurationPreference = "filesystemFirst",
                    showSyntaxErrors = true,
                    logLevel = "debug",
                    logFile = "/tmp/ruff.log",
                    lint = {
                        extendIgnore = { "F401" }
                    },
                    -- Any extra CLI arguments for `ruff` go here.
                    args = {},
                }
            },
            commands = {
                RuffAutofix = {
                    function()
                        vim.lsp.buf.execute_command {
                            command = 'ruff.applyAutofix',
                            arguments = {
                                { uri = vim.uri_from_bufnr(0) },
                            },
                        }
                    end,
                    description = 'Ruff: Fix all auto-fixable problems',
                },
                RuffOrganizeImports = {
                    function()
                        vim.lsp.buf.execute_command {
                            command = 'ruff.applyOrganizeImports',
                            arguments = {
                                { uri = vim.uri_from_bufnr(0) },
                            },
                        }
                    end,
                    description = 'Ruff: Format imports',
                }
            }
        }

        lspconfig["pyright"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "python" },
            settings = {
                pyright = {
                    -- Using Ruff's import organizer
                    disableOrganizeImports = true,
                },
                python = {
                    analysis = {
                        -- Ignore all files for analysis to exclusively use Ruff for linting
                        ignore = { '*' },
                    },
                },
            },
        })

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
