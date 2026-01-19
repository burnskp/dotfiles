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

-- Catppuccin Latte colors for tab bar
local catppuccin_latte = {
  base = "#eff1f5",
  blue = "#1e66f5",
  crust = "#dce0e8",
  mauve = "#8839ef",
  overlay2 = "#7c7f93",
  surface0 = "#ccd0da",
  surface1 = "#bcc0cc",
  text = "#4c4f69",
  yellow = "#df8e1d",
}

wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
  local title = tab_title(tab)
  local index = tostring(tab.tab_index + 1)

  local background
  local foreground
  local bar_background = catppuccin_latte.crust
  local num_background
  local num_foreground = catppuccin_latte.crust
  if string.find(title, "^Copy mode:") then
    background = catppuccin_latte.yellow
    foreground = catppuccin_latte.base
  elseif tab.is_active then
    background = catppuccin_latte.surface1
    foreground = catppuccin_latte.text
    num_background = catppuccin_latte.mauve
  else
    background = catppuccin_latte.surface0
    foreground = catppuccin_latte.text
    num_background = catppuccin_latte.overlay2
  end

  local display_title = string.sub(title, 1, max_width - 5)

  return {
    { Background = { Color = bar_background } },
    { Text = " " },
    { Background = { Color = num_background } },
    { Foreground = { Color = num_foreground } },
    { Text = " " .. index .. " " },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = " " .. display_title .. " " },
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

  config.color_scheme = "Catppuccin Latte"
  config.colors = {
    tab_bar = { background = catppuccin_latte.crust },
  }
end

return M
