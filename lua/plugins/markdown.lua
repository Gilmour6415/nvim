return {
  -- Disable markdown-preview.nvim
  {
    "iamcco/markdown-preview.nvim",
    enabled = false,
  },
  -- Disable render-markdown.nvim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },
  -- Disable marksman LSP for markdown and disable diagnostics
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = false, -- Disable marksman LSP server
      },
    },
    init = function()
      -- Disable diagnostics for markdown files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "markdown.mdx" },
        callback = function()
          -- Delay diagnostic disable to ensure module is loaded
          vim.defer_fn(function()
            if vim.diagnostic and vim.diagnostic.disable then
              vim.diagnostic.disable(0)
            end
          end, 100)
        end,
      })
    end,
  },
  -- Disable diagnostics for markdown files
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      -- Remove markdownlint diagnostics if present
      if opts.sources then
        local new_sources = {}
        for _, source in ipairs(opts.sources) do
          if not string.match(tostring(source), "markdownlint") then
            table.insert(new_sources, source)
          end
        end
        opts.sources = new_sources
      end
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      -- Remove markdown linters
      if opts.linters_by_ft and opts.linters_by_ft.markdown then
        opts.linters_by_ft.markdown = nil
      end
    end,
  },
}