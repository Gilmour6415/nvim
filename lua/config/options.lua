-- 在此添加自定义选项
vim.o.guifont = "Cousine Nerd Font Mono:h11"
vim.g.neovide_transparency = 0.9
vim.g.neovide_theme = "auto"
-- disable animations
vim.g.snacks_animate = false

-- custom colors
-- vim.cmd.highlight({ "WinSeparator", "guifg=#808080 guibg=#808080" })

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- warp settings
vim.opt.wrap = true

-- nvr configs for vimtex
local function set_server_name()
  local nvim_server_file
  if vim.fn.has("win32") == 1 then
    nvim_server_file = os.getenv("TEMP") .. "/curnvimserver.txt"
  else
    nvim_server_file = "/tmp/curnvimserver.txt"
  end
  local cmd = string.format("echo %s > %s", vim.v.servername, nvim_server_file)
  vim.fn.system(cmd)
end

--  使用传统的底部cmdline
require("noice").setup({
  cmdline = {
    view = "cmdline",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("vimtex_common", { clear = true }),
  pattern = "tex",
  callback = set_server_name,
})

-- 在 Python 文件中自动补全三引号
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- 插入模式下映射 """ 到完整的多行注释结构
    vim.keymap.set("i", '"""', '"""\n\n"""<ESC>O', {
      buffer = true,
      desc = "自动补全 Python 多行注释",
      noremap = true,
    })
    vim.keymap.set("i", "'''", '"""\n\n"""<ESC>O', {
      buffer = true,
      desc = "自动补全 Python 多行注释",
      noremap = true,
    })
  end,
})
