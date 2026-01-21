#!/usr/bin/env bash
set -e

THRESHOLD=10
NOTIFIED=false

# Find the first battery
BAT_PATH=$(echo /sys/class/power_supply/BAT* | cut -d' ' -f1)

if [[ ! -d "$BAT_PATH" ]]; then
  echo "No battery found"
  exit 1
fi

while true; do
  BATTERY=$(cat "$BAT_PATH/capacity")
  STATUS=$(cat "$BAT_PATH/status")

  if [[ "$STATUS" != "Charging" ]] && [[ "$BATTERY" -le "$THRESHOLD" ]]; then
    if [[ "$NOTIFIED" = false ]]; then
      notify-send -u critical -t 0 "Battery Low" "Battery at ${BATTERY}%"
      NOTIFIED=true
    fi
  else
    # Reset when battery is charging or above threshold
    NOTIFIED=false
  fi

  sleep 60
done
