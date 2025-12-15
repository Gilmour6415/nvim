-- 快捷键会在 VeryLazy 事件时自动加载
-- 默认快捷键配置参考: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- 在此处添加额外的快捷键配置
-- 打开编译器
vim.api.nvim_set_keymap("n", "<F5>", "<cmd>DapContinue<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-F5>", "<cmd>DapTerminate<cr>", { noremap = true, silent = true })

-- 使用 jj 替代 Esc 键
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })
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
-- tmux 窗口导航快捷键
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", {})
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", {})

-- 使用 leader + o 开启/关闭 copilot
vim.keymap.set("n", "<leader>o", "<cmd>Copilot toggle<cr>", { desc = "Toggle Copilot" })

-- CodeCompanionActions AI
vim.keymap.set({ "n", "v" }, "<leader>a", "", { desc = "CodeCompanionChat" })
vim.keymap.set({ "n", "v" }, "<Leader>ap", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<Leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
