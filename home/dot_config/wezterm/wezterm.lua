local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("keymap").config(config)
require("theme").config(config)
require("fonts").config(config)
require("smart-splits").config(config)
require("session").config(config)

config.front_end = "WebGpu"
config.term = "wezterm"
config.audible_bell = "Disabled"
config.exit_behavior = "Close"
config.notification_handling = "SuppressFromFocusedWindow"
config.scrollback_lines = 5000
config.skip_close_confirmation_for_processes_named = {}

config.quick_select_patterns = {
  "[a-z]+(?:-[a-z0-9]+)+-[a-z0-9]+",
  "[a-z]+(?:-[a-z0-9]{5})",
}

wezterm.on('gui-startup', function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)


return config
