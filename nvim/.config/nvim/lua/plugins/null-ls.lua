return {
    "nvimtools/none-ls.nvim",
    ft = { "python" },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- null_ls.builtins.diagnostics.mypy,
                null_ls.builtins.diagnostics.mypy.with({
                    extra_args = function()
                        return { "--python-executable", "/home/hristo/.pyenv/shims/python3" }
                    end,
                })
            },
        })
    end
}
