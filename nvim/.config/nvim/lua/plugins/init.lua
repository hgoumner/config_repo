return {
	--------------------------
	-- Colorscheme settings --
	--------------------------

	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs,
				contrast = "hard", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = true,
			})
			vim.cmd("colorscheme gruvbox")
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
		"kyazdani42/nvim-tree.lua",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
		keys = {
			{ "<leader>e", "<CMD>NvimTreeToggle<CR>", desc = "Toggle NVIM Tree" },
		},
		config = function()
			require("nvim-tree").setup()
		end,
	},

	-- Commenting
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup()
		end,
	},

	-- Formatting
	-- Surround words, etc
	{
		"kylechui/nvim-surround",
		lazy = false,
		config = function()
			require("nvim-surround").setup()
		end,
	},

	-- undotree
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>ut", ":UndotreeToggle<CR>", "Toggle Undotree" },
		},
	},

	-- align objects
	{
		"junegunn/vim-easy-align",
		lazy = false,
	},

	{
		"mikesmithgh/kitty-scrollback.nvim",
		enabled = true,
		lazy = true,
		cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
		event = { "User KittyScrollbackLaunch" },
		-- version = '*', -- latest stable version, may have breaking changes if major version changed
		-- version = '^5.0.0', -- pin major version, include fixes and features that do not have breaking changes
		config = function()
			require("kitty-scrollback").setup()
		end,
	},

	{
		"tzachar/local-highlight.nvim",
		config = function()
			require("local-highlight").setup({
				file_types = { "python" }, -- If this is given only attach to this
				hlgroup = "Search",
				cw_hlgroup = nil,
				-- Whether to display highlights in INSERT mode or not
				insert_mode = true,
				min_match_len = 1,
				max_match_len = math.huge,
				highlight_single_match = true,
			})
		end,
	},

	{
		"kevinhwang91/nvim-bqf",
		ft = { "qf" },
	},

	-------------------------
	-- Appearance settings --
	-------------------------

	--buffer_line
	{
		"akinsho/bufferline.nvim",
		lazy = false,
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("bufferline").setup({
				options = {
					separator_style = "slant",
				},
			})
		end,
	},

	{
		"hiphish/rainbow-delimiters.nvim",
		lazy = false,
	},

	-------------------------------
	-- Language specific plugins --
	-------------------------------

	{
		"imsnif/kdl.vim",
		ft = { "kdl" },
	},

	-------------------------------
	-- Testing -
	-------------------------------

	{
		"danymat/neogen",
		ft = { "python" },
		config = true,
		version = "*",
	},

	{ "echasnovski/mini.nvim", version = "*" },
}
