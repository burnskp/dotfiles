#!/bin/bash

THRESHOLD=10
NOTIFIED=false

while true; do
  BATTERY=$(cat /sys/class/power_supply/BAT*/capacity)
  STATUS=$(cat /sys/class/power_supply/BAT*/status)

  if [ "$STATUS" != "Charging" ] && [ "$BATTERY" -le "$THRESHOLD" ]; then
    if [ "$NOTIFIED" = false ]; then
      notify-send -u critical -t 0 "Battery Low" "Battery at ${BATTERY}%"
      NOTIFIED=true
    fi
  else
    # Reset when battery is charging or above threshold
    NOTIFIED=false
  fi

  sleep 60
done
