-- keifu.nvim（配置内本地插件）：用 snacks 的浮窗终端跑 keifu 这个 git 图谱 TUI
--
-- 走的是和 Snacks.lazygit 完全一样的路子：居中大浮窗 + backdrop，底下的窗口和 buffer
-- 一概不动。所以焦点在 neo-tree 里打开也不会把文件树搞坏 —— 之前自己接管窗口的写法
-- 会顶掉 neo-tree 的窗口，触发它的 autocmd 反过来关掉带活进程的终端，两边一起废。
--
-- 生命周期由 snacks 负责：keifu 里按 q → 进程退出 → TermClose → 浮窗自动关闭、
-- 终端 buffer 删除、焦点 wincmd p 回到原来的窗口；非零退出（比如 cwd 不是 git 仓库）
-- 会弹通知并保留界面，好让你看清 stderr。
local M = {}

---@class keifu.Opts
---@field cmd? string keifu 可执行文件
---@field args? string[] 追加给 keifu 的参数
---@field cwd? string 仓库路径，默认按当前 buffer 找 git root
---@field file_view? "fullscreen"|"replace" 透传 --file-view
---@field win? table 透传给 Snacks.terminal 的 win 配置

M.defaults = {
  cmd = "keifu",
  args = {},
  win = {},
}

-- 和 Snacks.config.style("lazygit", {}) 一样留一个样式钩子方便覆盖。
-- snacks 的终端浮窗默认只占 90%×90%，图谱这种全屏 TUI 铺得越满越好用；
-- 这里留一点点边（左右各 2 列、上下各 1 行），看起来是个浮层而不是糊在屏幕上。
-- width/height 可以是函数，所以窗口 resize 后会重新算。
Snacks.config.style("keifu", {
  width = function()
    return math.max(20, vim.o.columns - 4)
  end,
  height = function()
    return math.max(10, vim.o.lines - 2)
  end,
  backdrop = false,
})

---@param opts? keifu.Opts
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

-- keifu 没有指定仓库的参数，只能靠 cwd（GitRepository::discover(".")）
local function resolve_cwd(opts)
  if opts.cwd and opts.cwd ~= "" then
    return vim.fn.fnamemodify(opts.cwd, ":p")
  end
  return vim.fs.root(0, ".git") or vim.fn.getcwd()
end

---@param opts? keifu.Opts
function M.open(opts)
  opts = vim.tbl_deep_extend("force", M.config or M.defaults, opts or {})
  if vim.fn.executable(opts.cmd) ~= 1 then
    vim.notify(("找不到 %s，先装：cargo install keifu"):format(opts.cmd), vim.log.levels.ERROR)
    return nil
  end

  local cmd = { opts.cmd }
  vim.list_extend(cmd, opts.args or {})
  if opts.file_view then
    vim.list_extend(cmd, { "--file-view", opts.file_view })
  end

  ---@type snacks.terminal
  local terminal = Snacks.terminal(cmd, {
    cwd = resolve_cwd(opts),
    win = vim.tbl_deep_extend("force", {
      style = "keifu",
      -- terminal 样式默认 q = "hide"（藏起浮窗但进程还活着）；这里要的是 q 直接杀掉退出
      keys = { q = "close" },
    }, opts.win or {}),
  })
  M.terminal = terminal
  -- keifu 自己退出时 snacks 会关掉浮窗，这里同步清掉引用
  if terminal and terminal.on then
    terminal:on("BufWipeout", function()
      if M.terminal == terminal then
        M.terminal = nil
      end
    end, { buf = true })
  end
  return terminal
end

function M.close()
  local t = M.terminal
  M.terminal = nil
  if t and t.win and vim.api.nvim_win_is_valid(t.win) then
    pcall(function()
      t:close()
    end)
  end
end

return M
