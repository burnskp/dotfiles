return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "AndreM222/copilot-lualine" },
  opts = {
    options = {
      section_separators = "",
      component_separators = "",
    },
    sections = {
      lualine_a = { {
        "mode",
        fmt = function(str)
          return str:sub(1, 1)
        end,
      } },
      lualine_b = { "branch", "diff" },
      lualine_c = { "filename" },
      lualine_x = {
        {
          function()
            local status = vim.diagnostic.status()
            if status == "" then
              return nil
            end
            return status
          end,
          cond = function()
            return vim.diagnostic.status() ~= ""
          end,
        },
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    tabline = {
      lualine_a = {
        { "buffers", show_filename_only = true, show_modified_status = true, symbols = { modified = " +" } },
      },
    },
  },
}
