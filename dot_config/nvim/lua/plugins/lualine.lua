return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "AndreM222/copilot-lualine",
    },
    event = "VeryLazy",
    opts = function()
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "lsp_document_symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_c_normal",
      })
      return {
        options = {
          section_separators = "",
          component_separators = "",
        },
        disabled_filetypes = {
          statusline = { "NvimTree", "Avante", "AvanteInput" },
          winbar = { "NvimTree", "Avante", "AvanteInput" },
        },
        sections = {
          lualine_a = { { "mode", fmt = function(str) return str:sub(1, 1) end, }, },
          lualine_c = { 'filename', { symbols.get, cond = symbols.has } },
          lualine_x = {
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
              color = function()
                return {
                  fg =
                      Snacks.util.color("Constant")
                }
              end,
            },
            {
              require('mcphub.extensions.lualine'),
              cond = function()
                return vim.g.mcphub_executing ~= nil or vim.g.mcphub_status ~= "ready"
              end
            },
            {
              'copilot',
              show_colors = true,
              show_loading = true
            },
            'diagnostics',
            {
              function()
                return require("dap").status()
              end,
              icon = { "", color = { fg = Snacks.util.color("Debug") } }, -- nerd icon.
              cond = function()
                if not package.loaded.dap then
                  return false
                end
                local session = require("dap").session()
                return session ~= nil
              end,
            },
            'filetype',
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      }
    end,
    config = function(_, opts)
      table.insert(opts.sections.lualine_x, 1, { require("custom.companion_lualine") })
      require('lualine').setup(opts)
    end
  },
}
