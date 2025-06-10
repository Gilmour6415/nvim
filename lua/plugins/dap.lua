return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "nvim-neotest/nvim-nio" },
  -- stylua: ignore
  opts = {
    layouts = {
      {
        elements = {
          {
            id = "scopes",
            size = 0.4
          },
          {
            id = "breakpoints",
            size = 0.2
          },
          {
            id = "stacks",
            size = 0.2
          },
          {
            id = "watches",
            size = 0.2
          },
        },
        position = "left",
        size = 30,
      },
      {
        elements = {
          -- i closed repl here
          -- {
          --   id = "repl",
          --   size = 0.1
          -- },
          {
            id = "console",
            size = 1
          }
        },
        position = "bottom",
        size = 10,
      },
    },
  },
  config = function(_, opts)
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup(opts)

    -- show scope in float window
    vim.keymap.set("n", "<leader>df", function()
      -- require("dapui").float_element("hover")
      require("dapui").eval()
    end, { desc = "list inspect of elements" })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.open({})
    end
  end,
}
