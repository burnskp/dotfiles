return {
  "sindrets/diffview.nvim",
  config = function()
    require("diffview").setup({
      use_icons = true,
      enhanced_diff_hl = false,
      default_args = {
        DiffviewOpen = { "--imply-local" },
      },
      signs = {
        fold_closed = "",
        fold_open = "",
      },
      file_history_panel = {
        win_config = {
          position = "bottom",
          width = 35,
          height = 16,
        },
      },
    })
  end,
  keys = {
    {
      "<leader>gv",
      function()
        if next(require('diffview.lib').views) == nil then
          vim.cmd('DiffviewOpen')
        else
          vim.cmd('DiffviewClose')
        end
      end,
      desc = "DiffView"
    }
  }
}
