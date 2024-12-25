return {
	"lervag/vimtex",
	ft = { "tex" },
	config = function()
		-- PDF viewer
		-- vim.g.vimtex_view_general_viewer = 'org.kde.okular'
		-- vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'

		-- map local leader
		vim.g.maplocalleader = ","
	end,
}
