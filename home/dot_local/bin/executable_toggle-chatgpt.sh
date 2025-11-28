#!/usr/bin/env bash

INSTANCE="chatgpt.com"
URL="https://chatgpt.com"

# Check if a ChatGPT window exists in the i3 tree
if i3-msg -t get_tree | jq -e \
    '.. | objects | select(.window_properties? and .window_properties.instance=="'"$INSTANCE"'")' \
    >/dev/null 2>&1; then
    # Window exists: toggle from/to scratchpad
    i3-msg '[instance="'"$INSTANCE"'"] scratchpad show' >/dev/null
else
    # No window yet: start ChatGPT as an app window
    "$BROWSER" --class "$INSTANCE" --name "$INSTANCE" --app="$URL" >/dev/null 2>&1 &
fi
