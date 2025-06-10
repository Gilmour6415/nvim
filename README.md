# 💤 LazyVim - 我的 macOS Neovim 配置

这是一个基于 [LazyVim](https://github.com/LazyVim/LazyVim) 的 Neovim 配置模板。

## 快捷键提示

### 通用快捷键

- `<leader>o`: 打开/关闭大纲视图（Outline）。
- `jj`: 在插入模式下快速退出到普通模式（替代 `Esc`）。

### 调试相关

- `<F5>`: 启动或继续调试会话。
- `<C-F5>`: 终止调试会话。
- `<leader>df`: 在浮动窗口中显示当前作用域的元素。

### Avante 插件

- `<leader>an`: 创建一个新的 Avante 聊天会话。

### 主题与外观

- 默认主题为 `tokyonight-storm`，支持透明背景。

## 插件配置

### 主要插件

- **LazyVim**: 提供基础配置和插件管理。
- **nvim-dap-ui**: 调试界面支持。
- **outline.nvim**: 代码大纲视图。
- **avante.nvim**: 集成 AI 聊天功能。
- **tokyonight.nvim**: 默认主题。

### 其他插件

- 自动补全（`nvim-cmp`）、代码片段（`friendly-snippets`）、文件选择器（`telescope.nvim`）等。

## 安装与使用

1. 克隆仓库到 `~/.config/nvim`。
2. 确保已安装 [Neovim](https://neovim.io/) 和 [LazyVim 依赖项](https://lazyvim.github.io/installation)。
3. 启动 Neovim，插件将自动安装。

## 问题排查

如果遇到问题，请检查插件配置或更新插件到最新版本。
