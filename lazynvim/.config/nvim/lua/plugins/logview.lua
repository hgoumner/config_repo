return {
  {
    "hgoumner/logview.nvim",
    main = "logview",
    cmd = { "LogView", "LogFilter", "LogStream", "LogStreamStop" },
    event = { "BufReadPre *.log", "BufNewFile *.log" },
    opts = {
      auto = true,
      patterns = { "*.log" },
      error_background = 0.16,
    },
  },
}
