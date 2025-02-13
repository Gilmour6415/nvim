-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Open compiler
vim.api.nvim_set_keymap("n", "<F5>", "<cmd>DapContinue<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-F5>", "<cmd>DapTerminate<cr>", { noremap = true, silent = true })
