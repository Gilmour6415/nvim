return {
  {
    "amitds1997/remote-nvim.nvim",
    version = "*", -- Pin to GitHub releases
    dependencies = {
      "nvim-lua/plenary.nvim", -- For standard functions
      "MunifTanjim/nui.nvim", -- To build the plugin UI
      "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    config = function()
      require("remote-nvim").setup({
        -- SSH配置
        ssh_config = {
          ssh_config_file_paths = { os.getenv("HOME") .. "/.ssh/config" },
        },
        
        -- 远程配置
        remote = {
          copy_dirs = {
            config = {
              dirs = "*", -- 复制所有配置目录
            },
            data = {
              dirs = { "lazy" }, -- 只复制lazy插件管理器目录
              compression = {
                enabled = true, -- 启用压缩传输
              },
            },
          },
        },
        
        -- 离线模式
        offline_mode = {
          enabled = false,
          no_github = false,
        },
        
        -- 日志级别
        log_level = vim.log.levels.INFO,
      })
    end,
  },
  
  -- 确保 telescope 已安装（如果 LazyVim 没有默认启用）
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- 使用最新版本
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      -- 基本 telescope 配置
      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
          },
          sorting_strategy = "ascending",
          winblend = 0,
        },
      })
      
      -- 添加一些有用的键映射
      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
    end,
  },
}
