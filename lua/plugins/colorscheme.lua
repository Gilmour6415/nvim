-- all colorschemes are loaded here
return {
  {
    "tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
  {
    "shaunsingh/nord.nvim",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },

  { "titanzero/zephyrium" },
  { "tanvirtin/monokai.nvim" },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-storm",
    },
  },
}
