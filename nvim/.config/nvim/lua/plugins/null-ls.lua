return {
	"nvimtools/none-ls.nvim",
	ft = { "python" },
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			debug = true,
		})

		null_ls.register({
			name = "python",
			filetypes = { "python" },
			sources = {
				null_ls.builtins.diagnostics.mypy,
				-- null_ls.builtins.code_actions.gitsigns,
				-- null_ls.builtins.code_actions.refactoring,
			},
		})
	end,
}
