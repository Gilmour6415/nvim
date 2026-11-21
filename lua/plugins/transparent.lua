local is_ghostty = os.getenv("TERM_PROGRAM") == "ghostty"

return {
  "xiyaowong/transparent.nvim",
  cond = is_ghostty,
  config = function()
    require("transparent").setup({
      extra_groups = {
        "NormalFloat",
        "NvimTreeNormal",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeFloatBorder",
        "TelescopeNormal",
        "TelescopeBorder",
      },
    })
  end,
}
