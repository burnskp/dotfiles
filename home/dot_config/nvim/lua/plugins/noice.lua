return {
  {
    "folke/noice.nvim",
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("noice").setup({
        routes = {
          {
            filter = {
              event = "msg_show",
              kind = "search_count",
            },
            opts = { skip = true },
          },
        },
        lsp = {
          progress = {
            enabled = false,
          },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          inc_rename = true,
          long_message_to_split = true,
          lsp_doc_border = true,
        },
      })
    end,
    keys = {
      { "<leader>uN",  "",                                                                            desc = "+noice" },
      { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",                 desc = "Redirect Cmdline" },
      { "<leader>uNl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
      { "<leader>uNh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
      { "<leader>uNa", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
      { "<leader>uNd", function() require("noice").cmd("dismiss") end,                                desc = "Dismiss All" },
      { "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,              expr = true,              desc = "Scroll Forward",  mode = { "i", "n", "s" } },
      { "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,              expr = true,              desc = "Scroll Backward", mode = { "i", "n", "s" } },
    },
  }
}
