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
  local bar_background
  local background
  local foreground
  if wezterm.gui.get_appearance() == "Dark" then
    -- Catppuccin Macchiato
    bar_background = "#181926"
    if string.find(title, "^[0-9]: Copy mode:") then
      foreground = "#24273a"
      background = "#eed49f"
    elseif tab.is_active then
      foreground = "#24273a"
      background = "#cad3f5"
    else
      foreground = "#cad3f5"
      background = "#5b6078"
    end
  else
    -- Catppuccin Latte
    bar_background = "#dce0e8"
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
  local function scheme_for_appearance(appearance)
    if appearance:find "Dark" then
      return "Catppuccin Macchiato"
    else
      return "Catppuccin Latte"
    end
  end
  config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

  config.default_workspace = hostname
  config.inactive_pane_hsb = {}
  config.show_new_tab_button_in_tab_bar = false
  config.tab_bar_at_bottom = true
  config.tab_max_width = 20
  config.use_fancy_tab_bar = false
  config.window_decorations = "RESIZE"
end

return M
