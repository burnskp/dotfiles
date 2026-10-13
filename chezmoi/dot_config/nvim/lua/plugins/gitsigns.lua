return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
    },
  },
  keys = function()
    local gs = require("gitsigns")

    return {
      {
        "<leader>hr",
        function()
          gs.reset_hunk()
        end,
        desc = "Reset Hunk",
      },
      {
        "<leader>hs",
        function()
          gs.stage_hunk()
        end,
        desc = "Stage Hunk",
      },
      {
        "[h",
        function()
          gs.nav_hunk("prev")
        end,
        desc = "Prev Hunk",
      },
      {
        "]h",
        function()
          gs.nav_hunk("next")
        end,
        desc = "Prev Hunk",
      },
      {
        "<leader>gb",
        function()
          gs.blame_line()
        end,
        desc = "Blame Line",
      },
      {
        "<leader>gB",
        function()
          gs.blame()
        end,
        desc = "Git Blame",
      },
      {
        "<leader>hR",
        function()
          gs.reset_buffer()
        end,
        desc = "Reset Buffer",
      },
      {
        "<leader>hS",
        function()
          gs.stage_buffer()
        end,
        desc = "Stage Buffer",
      },
      {
        "<leader>hi",
        function()
          gs.preview_hunk_inline()
        end,
        desc = "Preview Hunk Inline",
      },
      {
        "<leader>hp",
        function()
          gs.preview_hunk()
        end,
        desc = "Preview Hunk",
      },
      {
        "<leader>hs",
        function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        desc = "Reset Hunk",
        mode = "v",
      },
      {
        "<leader>hr",
        function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        desc = "Reset Hunk",
        mode = "v",
      },
    }
  end,
}
