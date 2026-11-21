-- lazy spec：本目录同时就是插件根（lua/ + plugin/），dir 指回自己
-- 注意 lua/plugins/<目录>/init.lua 会被 lazy 的 import 当作 spec 读取，
-- 所以这个文件只能返回 spec 表，实现放在 lua/keifu.lua 里
return {
  dir = vim.fn.stdpath("config") .. "/lua/plugins/keifu",
  name = "keifu",
  lazy = true,
  dependencies = { "folke/snacks.nvim" },
  cmd = "Keifu",
  keys = {
    { "<leader>gk", "<cmd>Keifu<cr>", desc = "Keifu (git graph TUI)" },
  },
}
