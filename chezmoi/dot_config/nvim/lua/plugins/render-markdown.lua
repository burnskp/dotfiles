return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    anti_conceal = { enabled = true },
    code = { enabled = false },
    completions = { lsp = { enabled = true } },
    file_types = { "markdown" },
    heading = { sign = false },
    render_modes = { "n", "c", "t" },
  },
  ft = { "markdown" },
  config = function(_, opts)
    require("render-markdown").setup(opts)
    Snacks.toggle({
      name = "Render Markdown",
      get = function()
        return require("render-markdown.state").enabled
      end,
      set = function(enabled)
        local m = require("render-markdown")
        if enabled then
          m.enable()
        else
          m.disable()
        end
      end,
    }):map("<leader>um")
  end,
}
