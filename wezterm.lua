-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

local fqdn = wezterm.hostname()
local hostname = fqdn:match("([^%.]+)")

-- This will hold the configuration.
local config = wezterm.config_builder()

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

local function is_inside_vim(pane)
	local tty = pane:get_tty_name()
	if tty == nil then
		return false
	end

	local success, stdout, stderr = wezterm.run_child_process({
		"sh",
		"-c",
		"ps -o state= -o comm= -t"
			.. wezterm.shell_quote_arg(tty)
			.. " | "
			.. "grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'",
	})

	return success
end

local function is_outside_vim(pane)
	return not is_inside_vim(pane)
end

local function bind_if(cond, key, mods, action)
	local function callback(win, pane)
		if cond(pane) then
			win:perform_action(action, pane)
		else
			win:perform_action(act.SendKey({ key = key, mods = mods }), pane)
		end
	end

	return { key = key, mods = mods, action = wezterm.action_callback(callback) }
end

wezterm.on("update-status", function(window)
	window:set_right_status(wezterm.format({ {}, { Text = " " .. hostname .. " " } }))
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

config.front_end = "WebGpu"
config.term = "wezterm"

config.font = wezterm.font({
	family = "DejaVuSansM Nerd Font Mono",
})

config.bold_brightens_ansi_colors = "No"

if hostname == "cyberspace7" then
	config.font_size = 14.0
elseif hostname ~= "MBP" then
	config.font_size = 21.0
	config.window_decorations = "RESIZE"
else
	config.font_size = 22.0
	config.window_decorations = "RESIZE"
end

config.command_palette_font_size = 20.0
config.command_palette_fg_color = "#fefefe"
config.command_palette_bg_color = "#0d3a58"

config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 20

config.inactive_pane_hsb = {}

config.adjust_window_size_when_changing_font_size = false
config.audible_bell = "Disabled"
config.exit_behavior = "Close"
config.notification_handling = "SuppressFromFocusedWindow"
config.scrollback_lines = 5000
config.skip_close_confirmation_for_processes_named = {}
config.use_dead_keys = false

config.quick_select_patterns = {
	"[a-z]+(?:-[a-z0-9]+)+-[a-z0-9]+",
	"[a-z]+(?:-[a-z0-9]{5})",
	"\\d+-\\d+-\\d+_\\d+-\\d+-\\d+\\.(?:log|xml)",
}

config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }
config.disable_default_key_bindings = true
config.keys = {
	{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = act.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = act.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = act.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = act.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = act.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = act.ActivateTab(8) },

	{ key = "#", mods = "CTRL", action = act.ActivateTab(2) },
	{ key = "'", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "CMD", action = act.DecreaseFontSize },
	{ key = "-", mods = "LEADER", action = act.DecreaseFontSize },
	{ key = ";", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "=", mods = "CMD", action = act.ResetFontSize },
	{ key = "=", mods = "LEADER", action = act.IncreaseFontSize },
	{ key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
	{ key = "DownArrow", mods = "CMD", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "LeftArrow", mods = "CMD", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "P", mods = "CMD", action = act.ActivateCommandPalette },
	{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
	{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
	{ key = "Paste", mods = "NONE", action = act.PasteFrom("Clipboard") },
	{ key = "Q", mods = "LEADER", action = act.QuitApplication },
	{ key = "RightArrow", mods = "CMD", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "Space", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "Space", mods = "LEADER|CTRL", action = act.ActivateCopyMode },
	{ key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
	{ key = "q", mods = "CMD", action = act.QuitApplication },
	{ key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = true }) },
	{
		key = "U",
		mods = "LEADER",
		action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
	},
	{ key = "UpArrow", mods = "CMD", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "V", mods = "CMD", action = act.PasteFrom("Clipboard") },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
	{ key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "d", mods = "LEADER", action = act.ShowDebugOverlay },
	{
		key = "f",
		mods = "LEADER",
		action = act.QuickSelectArgs({
			label = "paste",
			action = wezterm.action_callback(function(window, pane)
				local selection = window:get_selection_text_for_pane(pane)
				pane:paste(selection)
			end),
		}),
	},
	{ key = "F", mods = "LEADER", action = act.QuickSelect },
	{ key = "s", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") },
	{
		key = "r",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Name:",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{ key = "n", mods = "LEADER", action = act.SpawnWindow },
	{ key = "p", mods = "LEADER", action = act.PasteFrom("Clipboard") },

	{
		key = "u",
		mods = "LEADER",
		action = wezterm.action.QuickSelectArgs({
			label = "open url",
			patterns = {
				"https?://\\S+",
			},
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				wezterm.log_info("opening: " .. url)
				wezterm.open_with(url)
			end),
		}),
	},
	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	bind_if(is_outside_vim, "h", "CTRL", act.ActivatePaneDirection("Left")),
	bind_if(is_outside_vim, "l", "CTRL", act.ActivatePaneDirection("Right")),
	bind_if(is_outside_vim, "j", "CTRL", act.ActivatePaneDirection("Down")),
	bind_if(is_outside_vim, "k", "CTRL", act.ActivatePaneDirection("Up")),
}

config.key_tables = {
	copy_mode = {
		{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{ key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },
		{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
		{ key = "Space", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
		{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
		{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
		{ key = "F", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
		{ key = "F", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
		{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
		{ key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
		{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
		{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
		{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
		{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
		{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
		{ key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
		{ key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
		{ key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
		{ key = "T", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
		{ key = "T", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
		{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
		{ key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
		{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
		{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
		{ key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
		{ key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
		{ key = "f", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
		{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
		{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
		{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
		{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
		{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
		{ key = "m", mods = "ALT", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "n", mods = "CTRL", action = act.CopyMode({ MoveForwardZoneOfType = "Input" }) },
		{ key = "p", mods = "CTRL", action = act.CopyMode({ MoveBackwardZoneOfType = "Input" }) },
		{ key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
		{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
		{
			key = "s",
			mods = "NONE",
			action = act.CopyMode({ SetSelectionMode = "SemanticZone" }),
		},
		{ key = "t", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
		{ key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
		{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
		{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{
			key = "y",
			mods = "NONE",
			action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }),
		},
		{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
		{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
		{ key = "End", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "Home", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
		{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{ key = "LeftArrow", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
		{ key = "RightArrow", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
		{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
	},

	search_mode = {
		{ key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
		{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
		{ key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
		{ key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
		{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
		{ key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
		{ key = "PageUp", mods = "NONE", action = act.CopyMode("PriorMatchPage") },
		{ key = "PageDown", mods = "NONE", action = act.CopyMode("NextMatchPage") },
	},
}

config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.Nop,
	},
	{
		event = { Up = { streak = 1, button = "Left" } },
		action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
		mods = "CMD",
	},
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = act.Nop,
	},
}

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

return config
