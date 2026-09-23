return {
  "rmagatti/auto-session",
  lazy = true,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~/", "~/Downloads", "/" },
    -- log_level = 'debug',
  },
}
