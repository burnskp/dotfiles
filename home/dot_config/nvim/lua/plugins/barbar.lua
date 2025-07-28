return {
  "romgrk/barbar.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    icons = {
      button = " ",
      buffer_index = false,
      filetype = { enabled = false },
      separator_at_end = false,
    },
    clickable = false,
    maximum_padding = 1,
  },
  keys = {
    { "<leader>bP", "<cmd>BufferPin<CR>",                 desc = "Pin Buffer" },
    { "<leader>bb", "<cmd>BufferOrderByBufferNumber<CR>", desc = "Order By Buffer" },
    { "<leader>bc", "<cmd>BufferClose<CR>",               desc = "Close Buffer" },
    { "<leader>bd", "<cmd>BufferOrderByDirectory<CR>",    desc = "Order By Directory" },
    { "<leader>bl", "<cmd>BufferOrderByLanguage<CR>",     desc = "Order By Language" },
    { "<leader>bn", "<cmd>BufferOrderByName<CR>",         desc = "Order By Name" },
    { "<leader>bp", "<cmd>BufferPick<CR>",                desc = "Pick Buffer" },
    { "<leader>br", "<cmd>BufferRestore<CR>",             desc = "Restore Buffer" },
    { "<leader>bw", "<cmd>BufferOrderByWindowNumber<CR>", desc = "Order By Window" },
  }
}
