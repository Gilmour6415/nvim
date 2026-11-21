return {
  {
    "SCJangra/table-nvim",
    ft = "markdown",
    opts = {},
    config = function(_, opts)
      require("table-nvim").setup(opts)

      vim.api.nvim_create_user_command("FormatAllTables", function()
        local ts = vim.treesitter
        local MdTable = require("table-nvim.md_table")

        local ok, parser = pcall(ts.get_parser, 0, "markdown")
        if not ok or not parser then
          vim.notify("No markdown parser available", vim.log.levels.WARN)
          return
        end

        local tree = parser:parse()[1]
        local root = tree:root()

        local tables = {}
        local function walk(node)
          if node:type() == "pipe_table" then
            table.insert(tables, { node = node, start = node:start() })
          end
          for child in node:iter_children() do
            walk(child)
          end
        end
        walk(root)

        if #tables == 0 then
          vim.notify("No tables found", vim.log.levels.INFO)
          return
        end

        -- 倒序处理，避免行号偏移
        table.sort(tables, function(a, b)
          return a.start > b.start
        end)

        for _, t in ipairs(tables) do
          MdTable:new(t.node):render()
        end
      end, {})

      vim.keymap.set("n", "<leader>mf", "<cmd>FormatAllTables<cr>", { desc = "Format all tables" })
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>m", group = "Markdown" },
      },
    },
  },
}
