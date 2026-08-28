return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      on_highlights = function (hl, c)
        hl.LineNrAbove = { fg = "#ffffff" }
        hl.CursorLineNr = { fg = "#297801" }
        hl.LineNrBelow = { fg = "#ff0000" }
      end
    },
  },

  -- Configure LazyVim to load tokyonight
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
