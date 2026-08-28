return {
  {
    "nvim-mini/mini.trailspace",
    version = false,
    event = "BufReadPost",
    opts = {},
    config = function(_, opts)
      require("mini.trailspace").setup(opts)

      -- Optional: Automatically trim trailing whitespaces when saving
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          require("mini.trailspace").trim()
        end,
      })
    end,
  },
}
