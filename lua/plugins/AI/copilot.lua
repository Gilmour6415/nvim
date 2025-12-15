return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  cmd = "CopilotChat",
  opts = function()
    local user = vim.env.USER or "User"
    user = user:sub(1, 1):upper() .. user:sub(2)
    return {
      auto_insert_mode = true,
      question_header = "  " .. user .. " ",
      answer_header = "  Copilot ",
      window = {
        width = 0.3,
      },
      language = "Chinese",
      model = "deepseek-chat",
      providers = {
        my_provider = {
          get_url = function(opts)
            return "https://api.deepseek.com/chat/completions"
          end,
          get_headers = function()
            return { ["Authorization"] = "Bearer " .. "sk-d61fcc515cc54ad1af8210b74eccfbd6" }
          end,
          get_models = function()
            return { { id = "deepseek-chat", name = "deepseek-chat" } }
          end,
          prepare_input = function(inputs, opts)
            local input = require("CopilotChat.config.providers").copilot.prepare_input(inputs, opts)
            input.stream = true
            return input
          end,
          prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,
        },
      },
    }
  end,
  keys = {
    { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
    { "<leader>h", "", desc = "CopilotChat", mode = { "n", "v" } },
    {
      "<leader>ha",
      function()
        return require("CopilotChat").toggle()
      end,
      desc = "Toggle (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>hx",
      function()
        return require("CopilotChat").reset()
      end,
      desc = "Clear (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>hq",
      function()
        vim.ui.input({
          prompt = "Quick Chat: ",
        }, function(input)
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end)
      end,
      desc = "Quick Chat (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>hp",
      function()
        require("CopilotChat").select_prompt()
      end,
      desc = "Prompt Actions (CopilotChat)",
      mode = { "n", "v" },
    },
  },
  config = function(_, opts)
    local chat = require("CopilotChat")

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "copilot-chat",
      callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
      end,
    })

    chat.setup(opts)
  end,
}
