return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    keys = {
      -- add a keymap to browshttps://github.com/cmu-db/bustub.gite plhttps://github.com/cmu-db/bustub.gitugin files
      -- stylua: ignore
      {
        "<f5>",
        function() require("dap").continue() end,
        desc = "launch/continue gdb",
      },
      {
        "<f10>",
        function()
          require("dap").step_over()
        end,
        desc = "单步调试",
      },
      {
        "<C-f10>",
        function()
          require("dap").step_into()
        end,
        desc = "步入",
      },
      {
        "<C-f>",
        function()
          require("dap").step_out()
        end,
        desc = "步出",
      },
      {
        "<C-f5>",
        function()
          require("dap").terminate()
        end,
        desc = "终止程序",
      },
    },
    config = function()
      local dap = require("dap")
      dap.defaults.fallback.terminal_win_cmd = "belowright 20new"
      dap.defaults.fallback.focus_terminal = true
      dap.adapters.gdb = {
        type = "executable",
        executable = {
          command = vim.fn.exepath("gdb"),
          args = { "-i", "dap" },
        },
      }
      dap.configurations.c = {
        name = "Launch file",
        type = "gdb",
        request = "launch",
        gdbpath = function()
          return "/usr/local/bin/gdb"
        end,
        cwd = "${workspaceFolder}",
      }
    end,
  },
}
