#!/usr/bin/env bash
INSTANCE="claude.ai"
URL="https://claude.ai/"
PROFILE="Default"

if i3-msg -t get_tree | jq -e \
    '.. | objects | select(.window_properties? and .window_properties.instance=="'"$INSTANCE"'")' \
    >/dev/null 2>&1; then
    i3-msg '[instance="'"$INSTANCE"'"] scratchpad show' >/dev/null
else
    helium-browser --profile-directory="$PROFILE" --class "$INSTANCE" --name "$INSTANCE" --app="$URL" >/dev/null 2>&1 &
    sleep 1
    i3-msg '[instance="'"$INSTANCE"'"] scratchpad show' >/dev/null
fi
