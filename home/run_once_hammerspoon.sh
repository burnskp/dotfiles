#!/bin/bash
if [[ "$(uname -o)" == "Darwin" ]]; then
  defaults write org.hammerspoon.Hammerspoon MJConfigFile "$XDG_CONFIG_HOME/hammerspoon/init.lua"
fi
