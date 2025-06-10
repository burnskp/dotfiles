return {

  "pwntester/octo.nvim",
  cmd = "Octo",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = function()
    vim.treesitter.language.register("markdown", "octo")
    return {
      picker = "snacks",
      enable_builtin = true,
      use_local_fs = true,
    }
  end,
  keys = {
    { "<leader>o",   "<cmd>Octo actions<cr>",          desc = "List Actions" },
    { "<leader>oa",  "<cmd>Octo actions<cr>",          desc = "List Actions" },
    { "<leader>oc",  "<cmd>Octo comment add<cr>",      desc = "Add Comment" },
    { "<leader>od",  "<cmd>Octo comment delete<cr>",   desc = "Delete Comment" },
    { "<leader>on",  "<cmd>Octo notification<cr>",     desc = "Notifications" },
    { "<leader>opC", "<cmd>Octo pr create<cr>",        desc = "Create PR" },
    { "<leader>opa", "<cmd>Octo pr checks<cr>",        desc = "Show PR Checks" },
    { "<leader>opb", "<cmd>Octo pr browser<cr>",       desc = "Open PR in Browser" },
    { "<leader>opc", "<cmd>Octo pr changes<cr>",       desc = "Show PR Changes" },
    { "<leader>opd", "<cmd>Octo pr diff<cr>",          desc = "Show PR Diffs" },
    { "<leader>opl", "<cmd>Octo pr list<cr>",          desc = "List PRs" },
    { "<leader>opr", "<cmd>Octo pr ready<cr>",         desc = "Mark PR Ready" },
    { "<leader>opu", "<cmd>Octo pr url<cr>",           desc = "Copy PR URL to clipboard" },
    { "<leader>orC", "<cmd>Octo pr checkout<cr>",      desc = "Checkout PR" },
    { "<leader>orR", "<cmd>Octo review resume<cr>",    desc = "Resume Review" },
    { "<leader>orc", "<cmd>Octo review commit<cr>",    desc = "Choose a commit" },
    { "<leader>orn", "<cmd>Octo review start<cr>",     desc = "Start Review" },
    { "<leader>orr", "<cmd>Octo thread resolve<cr>",   desc = "Mark thread resolved" },
    { "<leader>ors", "<cmd>Octo review submit<cr>",    desc = "Submit Review" },
    { "<leader>ort", "<cmd>Octo review comments<cr>",  desc = "View pending comments" },
    { "<leader>oru", "<cmd>Octo thread unresolve<cr>", desc = "Mark thread unresolved" },
    { "<leader>orx", "<cmd>Octo review close<cr>",     desc = "Close Review" },
    { "<leader>ou",  "<cmd>Octo repo url<cr>",         desc = "Copy repo url to clipboard" },
  }
}
