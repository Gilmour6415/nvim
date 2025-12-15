return {
  "nvim-lspconfig",
  opts = {
    ---@type lspconfig.options
    servers = {
      pyright = {
        capabilities = (function()
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
          return capabilities
        end)(),
        settings = {
          pyright = {
            settings = {
              pyright = {
                disableOrganizeImports = true, -- Using Ruff
              },
              python = {
                analysis = {
                  ignore = { "*" }, -- Using Ruff
                  typeCheckingMode = "off", -- Using mypy
                },
              },
            },
          },
        },
      },
    },
  },
}
