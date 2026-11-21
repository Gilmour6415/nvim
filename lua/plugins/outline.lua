return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "<leader>cs", "<cmd>Outline<CR>", desc = "Toggle Outline" },
  },
  opts = {
    outline_window = {
      position = "right",
      width = 25,
      relative_width = true,
    },
    symbol_folding = {
      autofold_depth = 1,
    },
    preview_window = {
      auto_preview = false,
    },
  },
}

