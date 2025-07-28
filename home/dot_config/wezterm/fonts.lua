local M = {}
local wezterm = require("wezterm")

M.config = function(config)
  config.adjust_window_size_when_changing_font_size = false
  config.command_palette_font_size = 20.0
  config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
  config.bold_brightens_ansi_colors = "No"
  config.freetype_load_flags = "FORCE_AUTOHINT"
  config.font = wezterm.font({
    family = "DejaVuSansM Nerd Font Mono"
  })
  config.font_size = 22.0
end

return M
