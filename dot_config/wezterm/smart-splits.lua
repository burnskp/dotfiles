local M = {}
local wezterm = require('wezterm')

local _smart_splits_wezterm_config = {
  default_amount = 3,
  direction_keys = { 'h', 'j', 'k', 'l' },
  modifiers = {
    move = 'CTRL',
    resize = 'META',
  },
  log_level = 'info',
}

local logger = {
  info = function(...)
    if _smart_splits_wezterm_config.log_level == 'info' then
      wezterm.log_info(...)
    end
  end,
  warn = function(...)
    if
        _smart_splits_wezterm_config.log_level == 'info' --
        or _smart_splits_wezterm_config.log_level == 'warn'
    then
      wezterm.log_warn(...)
    end
  end,
  error = function(...)
    if
        _smart_splits_wezterm_config.log_level == 'info'
        or _smart_splits_wezterm_config.log_level == 'warn'
        or _smart_splits_wezterm_config.log_level == 'error'
    then
      wezterm.log_error(...)
    end
  end,
}

local function is_vim(pane)
  -- if type is PaneInformation
  if pane.user_vars ~= nil then
    logger.info('[smart-splits.nvim]: PaneInformation.user_vars.IS_NVIM = ', pane.user_vars.IS_NVIM)
    return pane.user_vars.IS_NVIM == 'true'
  end

  -- this is set by the Neovim plugin on launch, and unset on ExitPre in Neovim
  logger.info('[smart-splits.nvim]: Pane:get_user_vars().IS_NVIM = ', pane:get_user_vars().IS_NVIM)
  return pane:get_user_vars().IS_NVIM == 'true'
end

local Directions = { 'Left', 'Down', 'Up', 'Right' }

local function split_nav(resize_or_move, key, direction)
  local modifier = resize_or_move == 'resize' and _smart_splits_wezterm_config.modifiers.resize
      or _smart_splits_wezterm_config.modifiers.move
  return {
    key = key,
    mods = modifier,
    action = wezterm.action_callback(function(win, pane)
      local num_panes = #win:active_tab():panes()
      if is_vim(pane) or num_panes == 1 then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = {
            key = key,
            mods = modifier,
          },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction, _smart_splits_wezterm_config.default_amount } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction }, pane)
        end
      end
    end),
  }
end

local function get_move_direction_keys()
  -- check if table format or list format
  if _smart_splits_wezterm_config.direction_keys.move ~= nil then
    return _smart_splits_wezterm_config.direction_keys.move
  end

  return _smart_splits_wezterm_config.direction_keys --[[@as string[] ]]
end

local function get_resize_direction_keys()
  -- check if table format or list format
  if _smart_splits_wezterm_config.direction_keys.resize ~= nil then
    return _smart_splits_wezterm_config.direction_keys.resize
  end

  return _smart_splits_wezterm_config.direction_keys --[[@as string[] ]]
end

local function apply_to_config(config_builder, plugin_config)
  -- apply plugin config
  if plugin_config then
    _smart_splits_wezterm_config.direction_keys = plugin_config.direction_keys
        or _smart_splits_wezterm_config.direction_keys
    if plugin_config.modifiers then
      _smart_splits_wezterm_config.modifiers.move = plugin_config.modifiers.move
          or _smart_splits_wezterm_config.modifiers.move
      _smart_splits_wezterm_config.modifiers.resize = plugin_config.modifiers.resize
          or _smart_splits_wezterm_config.modifiers.resize
    end
    if plugin_config.default_amount then
      _smart_splits_wezterm_config.default_amount = plugin_config.default_amount
          or _smart_splits_wezterm_config.default_amount
    end
    if plugin_config.log_level then
      _smart_splits_wezterm_config.log_level = plugin_config.log_level
    end
  end

  local keymaps = {}
  for idx, key in ipairs(get_move_direction_keys()) do
    table.insert(keymaps, split_nav('move', key, Directions[idx]))
  end
  for idx, key in ipairs(get_resize_direction_keys()) do
    table.insert(keymaps, split_nav('resize', key, Directions[idx]))
  end

  if config_builder.keys == nil then
    config_builder.keys = keymaps
  else
    for _, keymap in ipairs(keymaps) do
      table.insert(config_builder.keys, keymap)
    end
  end
  return config_builder
end


M.config = function(config)
  apply_to_config(config, {
    direction_keys = { 'h', 'j', 'k', 'l' },
    modifiers = { move = 'CTRL', resize = 'CTRL|SHIFT' },
    log_level = 'info',
  })
end

return M
