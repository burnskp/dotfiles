#!/bin/zsh

if ! [ -d "$HOME/.cache/bat" ]; then
  bat cache --build
fi
