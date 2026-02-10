vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
 { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main' },
}, { confirm = false })

require("nvim-treesitter").install({
  "diff",
  "dockerfile",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "json",
  "json5",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "ssh_config",
  "toml",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
})
