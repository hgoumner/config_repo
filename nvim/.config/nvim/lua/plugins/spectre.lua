return {
	"nvim-pack/nvim-spectre",
	lazy = false,
	config = function()
		vim.keymap.set("n", "<leader>sa", '<cmd>lua require("spectre").toggle()<CR>', {
			desc = "Toggle Spectre",
		})
		vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
			desc = "Search current word",
		})
		vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
			desc = "Search current word",
		})
		vim.keymap.set("n", "<leader>sc", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
			desc = "Search on current file",
		})
	end,
}
