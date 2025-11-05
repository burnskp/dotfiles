return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "cbfmt",
        "fixjson",
        "mdformat",
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft["json"] = { "fixjson" }
      opts.formatters_by_ft["*"] = { "trim_whitespace" }
      opts.formatters_by_ft["markdown"] = { "mdformat", "markdownlint-cli2", "markdown-toc", "cbfmt" }
      opts.formatters_by_ft["markdown.mdx"] = { "mdformat", "markdownlint-cli2", "markdown-toc", "cbfmt" }
      opts.formatters.sfmt = {
        prepend_args = { "-ci", "-s", "-i", "2", "-bn", "-sr" },
      }
    end,
  },
}
