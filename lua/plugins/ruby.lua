return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rubocop = false, -- Disable rubocop LSP server, let ruby-lsp handle linting
      },
    },
  },
}