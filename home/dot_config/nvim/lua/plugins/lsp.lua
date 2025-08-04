return {
  {
    lazy = false,
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
        "bashls",
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
    keys = {
      { "<c-k>",      function() return vim.lsp.buf.signature_help() end, mode = "i",                          desc = "Signature Help", },
      { "<leader>la", vim.lsp.buf.code_action,                            desc = "Code Action",                mode = { "n", "v" }, },
      { "<leader>lC", vim.lsp.codelens.refresh,                           desc = "Refresh & Display Codelens", mode = { "n" }, },
      { "<leader>lc", vim.lsp.codelens.run,                               desc = "Run Codelens",               mode = { "n", "v" }, },
      { "<leader>ll", function() Snacks.picker.lsp_config() end,          desc = "Lsp Info" },
      { "<leader>lf", function() vim.lsp.buf.format() end,                desc = "Format" },
      { "<leader>lR", function() Snacks.rename.rename_file() end,         desc = "Rename File",                mode = { "n" }, },
      { "<leader>lr", vim.lsp.buf.rename,                                 desc = "Rename", },
      {
        "<leader>ls",
        function() Snacks.picker.lsp_symbols() end,
        desc = "LSP Symbols",
      },
      {
        "<leader>lS",
        function() Snacks.picker.lsp_workspace_symbols() end,
        desc = "LSP Workspace Symbols"
      },
      {
        "K",
        function() return vim.lsp.buf.hover() end,
        desc = "Hover"
      },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      {
        "gI",
        function() Snacks.picker.lsp_implementations() end,
        desc = "Goto Implementation"
      },
      {
        "gK",
        function()
          return vim.lsp.buf.signature_help()
        end,
        desc = "Signature Help",
      },
      {
        "gd",
        function() Snacks.picker.lsp_definitions() end,
        desc = "Goto Definition"
      },
      {
        "gr",
        function() Snacks.picker.lsp_references() end,
        nowait = true,
        desc = "References"
      },
      {
        "gy",
        function() Snacks.picker.lsp_type_definitions() end,
        desc = "Goto Type Definition"
      },
    }
  }
}
