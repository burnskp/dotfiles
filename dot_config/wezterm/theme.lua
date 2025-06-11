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

  -- Catppuccin Latte
  local foreground
  local background
  local bar_background = "#dce0e8"
  if string.find(title, "^[0-9]: Copy mode:") then
    foreground = "#eff1f5"
    background = "#df8e1d"
  elseif tab.is_active then
    foreground = "#eff1f5"
    background = "#4c4f69"
  else
    foreground = "#4c4f69"
    background = "#acb0be"
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
  config.color_scheme = "Catppuccin Latte"

  config.default_workspace = hostname
  config.inactive_pane_hsb = {}
  config.show_new_tab_button_in_tab_bar = false
  config.tab_bar_at_bottom = true
  config.tab_max_width = 20
  config.use_fancy_tab_bar = false
  config.window_decorations = "RESIZE"
end

return M
