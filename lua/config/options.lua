-- 在此添加自定义选项
vim.g.neovide_transparency = 0.9
vim.o.guifont = "Cousine Nerd Font Mono:h11"
vim.g.neovide_theme = "auto"
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- disable animations
vim.g.snacks_animate = false

vim.api.nvim_set_option("background", "dark")

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- custom colors
vim.cmd.highlight({ "WinSeparator", "guifg=#323232 guibg=#323232" })
