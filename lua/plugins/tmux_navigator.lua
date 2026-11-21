return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
    -- 关闭插件自带的 Ctrl+hjkl 映射，统一由 config.herdr_navigator 接管
    vim.g.tmux_navigator_no_mappings = 1
  end,
}
