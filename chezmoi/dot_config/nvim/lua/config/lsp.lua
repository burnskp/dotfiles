local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
})

vim.lsp.enable({
  "bashls",
  "jsonls",
  "lua_ls",
  "marksman",
  "rust_analyzer",
  "yamlls",
})
