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
    local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
    local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)

    return {
      { "<leader>hr", function() gs.reset_hunk() end,          desc = "Reset Hunk" },
      { "<leader>hs", function() gs.stage_hunk() end,          desc = "Stage Hunk" },
      { "[H",         function() gs.nav_hunk("first") end,     desc = "First Hunk" },
      { "[h",         prev_hunk_repeat,                        desc = "Prev Hunk" },
      { "]H",         function() gs.nav_hunk("last") end,      desc = "Last Hunk" },
      { "]h",         next_hunk_repeat,                        desc = "Next Hunk" },
      { '<leader>gb', function() gs.blame_line() end,          desc = "Blame Line" },
      { '<leader>gB', function() gs.blame() end,               desc = "Git Blame" },
      { '<leader>hR', function() gs.reset_buffer() end,        desc = "Reset Buffer" },
      { '<leader>hS', function() gs.stage_buffer() end,        desc = "Stage Buffer" },
      { '<leader>hi', function() gs.preview_hunk_inline() end, desc = "Preview Hunk Inline" },
      { '<leader>hp', function() gs.preview_hunk() end,        desc = "Preview Hunk" },
      {
        "<leader>hs",
        function()
          require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end,
        desc = "Reset Hunk",
        mode = "v"
      },
      {
        '<leader>hr',
        function()
          require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end,
        desc = "Reset Hunk",
        mode = "v"
      },
    }
  end
}
