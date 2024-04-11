return {
    'rcarriga/nvim-notify',
    lazy = false,
    config = function()

        vim.opt.termguicolors = true

        require("notify").setup {
            background_colour = "#000000",
        }
    end,
}
