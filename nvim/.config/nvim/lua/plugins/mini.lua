return {
	{
		"echasnovski/mini.ai",
		version = "*",
		lazy = false,
		config = function()
			local spec_treesitter = require("mini.ai").gen_spec.treesitter
			require("mini.ai").setup({
				custom_textobjects = {
					f = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
					c = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
					o = spec_treesitter({
						a = { "@conditional.outer", "@loop.outer" },
						i = { "@conditional.inner", "@loop.inner" },
					}),
				},
			})
		end,
	},
	{
		"echasnovski/mini.align",
		version = "*",
		lazy = false,
		config = function()
			require("mini.align").setup()
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = "*",
		lazy = false,
		config = function()
			require("mini.indentscope").setup()
		end,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		lazy = true,
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"echasnovski/mini.notify",
		version = "*",
		lazy = false,
		config = function()
			require("mini.notify").setup()
		end,
	},
}
