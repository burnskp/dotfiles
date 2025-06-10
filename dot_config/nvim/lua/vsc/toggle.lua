return {
  "folke/snacks.nvim",
  init = function()
    vim.api.nvim_create_autocmd({
      "BufWritePre",
    }, {
      callback = function()
        if vim.g.autoFormat then
          vim.lsp.buf.format()
        end
      end,
    })

    vim.g.autoFormat = true

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
          "<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.option("showtabline",
          { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }):map("<leader>uA")
        Snacks.toggle({
          name = "Auto Format",
          get = function()
            return vim.g.autoFormat
          end,
          set = function(state)
            vim.g.autoFormat = state
          end
        }):map("<leader>uf")
        Snacks.toggle({
          name = "Git Signs",
          get = function()
            return require("gitsigns.config").config.signcolumn
          end,
          set = function(state)
            require("gitsigns").toggle_signs(state)
          end,
        }):map("<leader>uG")
      end,
    })
  end
}
