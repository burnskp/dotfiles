return {
  {
    "chrisgrieser/nvim-scissors",
    opts = {
      jsonFormatter = "jq",
    },
    keys = {
      { "<leader>qa", function() require("scissors").addNewSnippet() end, desc = "Add Snippets" },
      { "<leader>qe", function() require("scissors").editSnippet() end,   desc = "Edit Snippets" },
    }
  },
}
