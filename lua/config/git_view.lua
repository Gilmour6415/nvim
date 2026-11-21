-- gitgraph / keifu 共用：接管哪个窗口、退出后「回到哪」的逻辑
--
-- 三个坑：
-- 1. 启动页（snacks dashboard）的 buffer 是 bufhidden=wipe，切走的那一刻就被销毁，
--    无处可回 —— 这种情况重开启动页，而不是掉进空白 buffer。
-- 2. 从启动页打开 gitgraph/keifu 时，图形界面其实是画在启动页那个**全屏浮窗**里的。
--    退出时如果不把浮窗收掉，人会留在浮窗里，而且每开关一次就多叠一层浮窗。
-- 3. 焦点在 neo-tree 这类常驻面板里时，绝不能接管它的窗口（详见 target_win）。
local M = {}

-- 无名空 buffer（或已失效的 buffer）都算 blank
function M.is_blank(buf)
  if not buf or not vim.api.nvim_buf_is_valid(buf) then
    return true
  end
  return vim.api.nvim_buf_get_name(buf) == ""
    and vim.api.nvim_buf_line_count(buf) == 1
    and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""
end

local function is_float(win)
  return vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_config(win).relative ~= ""
end

-- 3. 别的插件的常驻面板窗口不能接管。实测：焦点在 neo-tree 窗口里打开 keifu，
--    keifu 占掉 neo-tree 的窗口后，neo-tree 的 autocmd 反过来把这个带活进程的终端窗口关掉，
--    keifu 收到 SIGHUP（退出码 129），neo-tree 状态也废了，之后再打不开。
local PANEL_FT = {
  ["neo-tree"] = true,
  NvimTree = true,
  oil = true,
  undotree = true,
  aerial = true,
  Outline = true,
  ["symbols-outline"] = true,
  trouble = true,
  DiffviewFiles = true,
  DiffviewFileHistory = true,
  lazy = true,
  Mason = true,
  help = true,
}

local function is_panel(win)
  local buf = vim.api.nvim_win_get_buf(win)
  local buftype = vim.bo[buf].buftype
  if buftype == "quickfix" or buftype == "terminal" or buftype == "prompt" then
    return true
  end
  return PANEL_FT[vim.bo[buf].filetype] == true
end

-- 挑一个能安全接管的窗口：优先当前窗口；当前是面板就换一个普通窗口；
-- 全是面板（比如 :only 之后只剩文件树）才自己开一个分屏，绝不动别人的窗口
---@return integer
function M.target_win()
  local cur = vim.api.nvim_get_current_win()
  if not is_panel(cur) then
    return cur
  end
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    if not is_float(w) and not is_panel(w) then
      vim.api.nvim_set_current_win(w)
      return w
    end
  end
  vim.cmd("botright vsplit")
  vim.cmd("enew")
  return vim.api.nvim_get_current_win()
end

-- 浮窗就收掉，回到真实窗口；收不掉（比如是最后一个窗口）就返回 nil 交给调用方兜底
local function to_real_win(win)
  if not win or not vim.api.nvim_win_is_valid(win) then
    return nil
  end
  if not is_float(win) then
    return win
  end
  pcall(vim.api.nvim_win_close, win, true)
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    if not is_float(w) then
      return w
    end
  end
  return nil
end

-- 收掉上一轮遗留的启动页浮窗，避免越叠越多
local function close_stale_dashboards()
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    local b = vim.api.nvim_win_get_buf(w)
    if is_float(w) and vim.bo[b].filetype == "snacks_dashboard" then
      pcall(vim.api.nvim_win_close, w, true)
    end
  end
end

-- 在 win（默认当前窗口）里恢复 buf；buf 是空白 buffer 时再盖一层启动页。
--
-- 顺序很关键：必须先把窗口切回 buf，再开启动页。启动页是全屏浮窗，不动底下的窗口；
-- 直接开浮窗的话，被替换掉的 gitgraph / keifu 终端 buffer 仍显示在原窗口里，
-- 既不会被 wipe，还会留下一个多余窗口。
function M.return_to(buf, win)
  win = to_real_win(win or 0)
  if win and win ~= 0 then
    vim.api.nvim_set_current_win(win)
  end
  local usable = buf ~= nil and vim.api.nvim_buf_is_valid(buf)
  if usable then
    vim.api.nvim_win_set_buf(0, buf)
  end
  if not M.is_blank(buf) then
    return
  end
  close_stale_dashboards()
  if pcall(function()
    require("snacks").dashboard.open()
  end) then
    return
  end
  if not usable then
    vim.cmd("enew")
  end
end

return M
