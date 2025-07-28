local M = {}
local wezterm = require("wezterm")
local sessionizer = require("sessionizer")
local history = require("sessionizer-history")

local custom_callback = function(window, pane, id, _)
  if not id then return end
  -- Extract the name as everything after the last '/'
  local name = id:match("([^/]+)$") or id
  window:perform_action(
    wezterm.action.SwitchToWorkspace({ name = name, spawn = { cwd = id, args = { "zsh", "-lc", "nvim" } } }), pane)
end

local color_prefix
local color_repo
if wezterm.gui.get_appearance() == "Dark" then
  color_prefix = "#8bd5ca"
  color_repo = "#cad3f5"
else
  color_prefix = "#179299"
  color_repo = "#4c4f69"
end


local schema = {
  options = { callback = history.Wrapper(custom_callback) },
  {
    sessionizer.FdSearch { wezterm.home_dir .. "/git", max_depth = 3 },
    processing = sessionizer.for_each_entry(function(entry)
      -- Extract just the first directory after git
      local prefix = entry.id:gsub(wezterm.home_dir .. "/git/", ""):match("^([^/]+)")
      entry.label = wezterm.format {
        { Foreground = { Color = color_prefix } },
        { Text = prefix .. ": " },
        { Foreground = { Color = color_repo } },
        { Text = entry.id:gsub(wezterm.home_dir .. "/git/" .. prefix .. "/", "") },
      }
    end)
  },
  {
    sessionizer.FdSearchDir { wezterm.home_dir .. "/projects", max_depth = 1 },
    processing = sessionizer.for_each_entry(function(entry)
      entry.label = wezterm.format {
        { Foreground = { Color = color_prefix } },
        { Text = "project: " },
        { Foreground = { Color = color_repo } },
        { Text = entry.id:gsub(wezterm.home_dir .. "/projects/", "") }
      }
    end)
  }
}

local switch_workspaces = {
  options = {
    prompt = "Workspace to switch: ",
    callback = history.Wrapper(sessionizer.DefaultCallback)
  },
  {
    sessionizer.AllActiveWorkspaces { filter_current = false, filter_default = false },
    processing = sessionizer.for_each_entry(function(entry)
      entry.label = wezterm.format {
        { Text = "󱂬 : " .. entry.label },
      }
    end)
  }
}


M.config = function(config)
  table.insert(config.keys, { key = "s", mods = "LEADER", action = sessionizer.show(schema) })
  table.insert(config.keys, { key = "m", mods = "LEADER", action = history.switch_to_most_recent_workspace })
  table.insert(config.keys, { key = "S", mods = "LEADER", action = sessionizer.show(switch_workspaces) })
end

return M
