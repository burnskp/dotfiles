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


local schema = {
  options = { callback = history.Wrapper(custom_callback) },
  {
    wezterm.home_dir .. "/git/dotfiles",
    processing = sessionizer.for_each_entry(function(entry)
      entry.label = wezterm.format {
        { Foreground = { Color = "#1478db" } },
        { Text = "dotfiles" },
      }
    end)
  },
  {
    sessionizer.FdSearch { wezterm.home_dir .. "/git/aicloud", max_depth = 2 },
    processing = sessionizer.for_each_entry(function(entry)
      entry.label = wezterm.format {
        { Foreground = { Color = "#33ff00" } },
        { Text = "aicloud: " },
        { Foreground = { Color = "#f0f0f0" } },
        { Text = entry.id:gsub(wezterm.home_dir .. "/git/aicloud/", "") },
      }
    end)
  },
  {
    sessionizer.FdSearch { wezterm.home_dir .. "/git/tp", max_depth = 2 },
    processing = sessionizer.for_each_entry(function(entry)
      entry.label = wezterm.format {
        { Foreground = { Color = "#00ffff" } },
        { Text = "third-party: " },
        { Foreground = { Color = "#f0f0f0" } },
        { Text = entry.id:gsub(wezterm.home_dir .. "/git/tp/", "") }
      }
    end)
  },
  {
    sessionizer.FdSearchDir { wezterm.home_dir .. "/projects", max_depth = 1 },
    processing = sessionizer.for_each_entry(function(entry)
      entry.label = wezterm.format {
        { Foreground = { Color = "#1478db" } },
        { Text = "project: " },
        { Foreground = { Color = "#f0f0f0" } },
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
