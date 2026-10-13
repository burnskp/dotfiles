return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = { use_default_keymaps = false },
  keys = {
    { "gj", function() require("treesj").join() end,  desc = "Treesj join" },
    { "gs", function() require("treesj").split() end, desc = "Treesj split" },
    { "gt", function() require("treesj").toggle() end, desc = "Treesj toggle" },
  }
}
