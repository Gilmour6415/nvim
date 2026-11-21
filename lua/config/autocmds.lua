-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable spell check for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "markdown.mdx" },
  callback = function()
    vim.opt_local.spell = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "c",
    "cpp",
    "h",
    "hpp",
  },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

-- diffview 键位：本文件在 VeryLazy 阶段加载，晚于各 picker 插件的占位映射，直接覆盖
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview (working tree)" })
vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewFileHistory<cr>", { desc = "Diffview (file history)" })

-- gitgraph 取代 lazygit 的 gg/gG；snacks.nvim 在 VeryLazy 链中较晚注册同名键，
-- 用 schedule 推迟到整个启动事件链之后，确保覆盖生效
-- 「退出后回到哪」与 keifu 插件共用 config/git_view.lua
local GitView = require("config.git_view")

local function open_git_graph(args)
  -- 别接管 neo-tree 这类常驻面板的窗口，否则会把它们的插件状态搞坏
  local win = GitView.target_win()
  local prev_buf = vim.api.nvim_win_get_buf(win)
  require("gitgraph").draw({}, args)
  local graph_buf = vim.api.nvim_get_current_buf()
  if graph_buf == prev_buf then
    return
  end
  vim.keymap.set("n", "q", function()
    GitView.return_to(prev_buf)
  end, { buffer = graph_buf, desc = "Close git graph" })
end

vim.schedule(function()
  vim.keymap.set("n", "<leader>gg", function()
    open_git_graph({ max_count = 5000 })
  end, { desc = "Git Graph (current branch)" })
  vim.keymap.set("n", "<leader>gG", function()
    open_git_graph({ all = true, max_count = 5000 })
  end, { desc = "Git Graph (all branches)" })
end)
