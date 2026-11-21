-- 快捷键会在 VeryLazy 事件时自动加载
-- 默认快捷键配置参考: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- 在此处添加额外的快捷键配置
-- 打开编译器
vim.api.nvim_set_keymap("n", "<F5>", "<cmd>DapContinue<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-F5>", "<cmd>DapTerminate<cr>", { noremap = true, silent = true })

-- 使用 jj 替代 Esc 键
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<D-s>", "<cmd>w<cr>", { desc = "保存文件 (Cmd+s)" })
-- vim.api.nvim_set_keymap("v", "jj", "<Esc>", { noremap = true, silent = true })

-- Yanky 插件的配置
-- 增强复制粘贴功能的快捷键映射

-- 基础粘贴功能：替换默认粘贴行为
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "粘贴到光标后" })
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "粘贴到光标前" })
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "粘贴并保持光标位置" })
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "粘贴到前面并保持光标位置" })

-- 历史记录导航：在粘贴历史中前后切换
vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)", { desc = "上一个粘贴项" })
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)", { desc = "下一个粘贴项" })
-- Ctrl+hjkl 导航由 config/herdr_navigator.lua（经 tmux_navigator 插件）统一接管

-- 终端模式下连续两次 Esc 等同于 Ctrl-\ Ctrl-n（退出终端模式）
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Double Esc to exit terminal mode" })

-- Ctrl+hjkl 无缝导航（vim 分屏 + herdr pane）。必须放在文件末尾：
-- LazyVim 在 VeryLazy 加载完自带 keymaps 后才加载本文件，此处覆盖才能生效。
require("config.herdr_navigator")
