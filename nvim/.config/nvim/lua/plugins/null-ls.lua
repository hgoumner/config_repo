return {
	"nvimtools/none-ls.nvim",
	ft = { "python" },
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.diagnostics.mypy,
			},
		})
	end,
}
