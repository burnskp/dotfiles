return {
  {
    "mason-org/mason-lspconfig.nvim",
    build = ":MasonUpdate",
    dependencies = {
      { "b0o/schemastore.nvim" },
      { "neovim/nvim-lspconfig" },
      { "mason-org/mason-lspconfig.nvim" },
      { "mason-org/mason.nvim" },
    },
    opts = {
      ensure_installed = {
        "ansiblels",
        "awk_ls",
        "dockerls",
        "golangci_lint_ls",
        "gopls",
        "helm_ls",
        "jsonls",
        "lua_ls",
        "marksman",
        "pyright",
        "regols",
        "ruff",
        "rust_analyzer",
        "taplo",
        "yamlls",
      },
    },
  }
}
