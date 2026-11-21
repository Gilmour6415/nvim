-- all colorschemes are loaded here
local function get_term_program()
  return os.getenv("TERM_PROGRAM")
end

local is_ghostty = get_term_program() == "ghostty"
local default_colorscheme = "moonfly"
local ghostty_colorscheme = "moonfly"
local colorscheme = is_ghostty and ghostty_colorscheme or default_colorscheme

return {
  {
    "tokyonight.nvim",
    opts = {
      transparent = is_ghostty,
      styles = is_ghostty and {
        sidebars = "transparent",
        floats = "transparent",
      } or {},
    },
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = is_ghostty,
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = is_ghostty,
    },
  },
  {
    "shaunsingh/nord.nvim",
  },
  {
    "catppuccin/nvim",
    opts = {
      transparent_background = is_ghostty,
      styles = is_ghostty and {
        sidebars = "transparent",
        floats = "transparent",
      } or {},
    },
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.moonflyTransparent = true
    end,
  },
  { "datsfilipe/vesper.nvim" },
  { "luisiacc/the-matrix.nvim" },

  { "titanzero/zephyrium" },
  { "tanvirtin/monokai.nvim" },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = colorscheme,
    },
  },
}
