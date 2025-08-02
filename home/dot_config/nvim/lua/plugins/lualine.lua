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
              function()
                -- Check if MCPHub is loaded
                if not vim.g.loaded_mcphub then
                  return
                end
                return "󰐻 "
              end,
              color = function()
                local status = vim.g.mcphub_status or "stopped"
                if status == "ready" or status == "restarted" then
                  return { fg = "#40a02b" }
                elseif status == "starting" or status == "restarting" then
                  return { fg = "#dc8a78" }
                elseif status == "stopped" then
                  return { fg = "#5c5f77" }
                else
                  return { fg = "#d20f39" }
                end
              end,
            },
            {
              'copilot',
              show_colors = true,
              show_loading = true,
              symbols = {
                status = {
                  icons = {
                    enabled = " ",
                    sleep = " ", -- auto-trigger disabled
                    disabled = " ",
                    warning = " ",
                    unknown = " "
                  },
                  hl = {
                    enabled = "#40a02b",
                    sleep = "#179299",
                    disabled = "#d20f39",
                    warning = "#d20f39",
                    unknown = "#fe640b"
                  }
                }
              },
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
