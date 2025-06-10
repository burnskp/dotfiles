local M = {}
local wezterm = require("wezterm")
local fqdn = wezterm.hostname()
local hostname = fqdn:match("([^%.]+)")

local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on("update-status", function(window)
  window:set_right_status(wezterm.format({ { Text = " " .. window:active_workspace() .. " " } }))
end)

wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
  local title = tostring(tab.tab_index + 1) .. ": " .. tab_title(tab)

  local bar_background = "#0E3A59"
  local background
  local foreground
  if string.find(title, "^[0-9]: Copy mode:") then
    background = "#ffc600"
    foreground = "#000000"
  elseif tab.is_active then
    background = "#0050A5"
    foreground = "#ffffff"
  else
    background = "#275D84"
    foreground = "#ffffff"
  end


  return {
    { Background = { Color = bar_background } },
    { Text = " " },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = " " .. string.sub(title, 1, max_width - 3) .. " " },
  }
end)

---@param config unknown
function M.config(config)
  config.default_workspace = hostname
  config.inactive_pane_hsb = {}
  config.show_new_tab_button_in_tab_bar = false
  config.tab_bar_at_bottom = true
  config.tab_max_width = 20
  config.use_fancy_tab_bar = false
  config.window_decorations = "RESIZE"

  config.command_palette_fg_color = "#fefefe"
  config.command_palette_bg_color = "#0d3a58"

  config.colors = {
    foreground = "#f0f0f0",
    background = "#193549",

    cursor_bg = "#ffc600",
    cursor_border = "#ffc600",
    compose_cursor = "#1478db",

    selection_fg = "#f0f0f0",
    selection_bg = "#275d84",

    split = "#1460d2",

    copy_mode_active_highlight_bg = { Color = "#ffff00" },
    copy_mode_inactive_highlight_bg = { Color = "#ffc600" },

    quick_select_label_bg = { Color = "#1478db" },
    quick_select_label_fg = { Color = "#fefefe" },
    quick_select_match_bg = { Color = "#275d84" },
    quick_select_match_fg = { Color = "#fefefe" },

    tab_bar = { background = "#0E3A59" },

    ansi = {
      "#000000",
      "#ff2600",
      "#3ad900",
      "#ffc600",
      "#1478db",
      "#ff2c70",
      "#00c5c7",
      "#c7c7c7",
    },
    brights = {
      "#808080",
      "#ff0000",
      "#33ff00",
      "#ffff00",
      "#1478db",
      "#cc00ff",
      "#00ffff",
      "#fefefe",
    },

    indexed = {
      [16] = "#ff8c00",
      [17] = "#0088ff",
      [18] = "#5555ff",
      [237] = "#555555",
    },
  }
end

return M
