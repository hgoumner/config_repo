vim.opt_local.foldmethod = "indent"
vim.opt_local.foldenable = true
vim.opt_local.foldlevel = 99

vim.b.miniai_config = {
  custom_textobjects = {
    i = require("mini.ai").gen_spec.treesitter({
      a = "@assignment.outer",
      i = "@assignment.rhs",
    }),
  },
}

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "")
  .. "\nsetlocal foldmethod< foldenable< foldlevel<"
  .. "\nunlet! b:miniai_config"
