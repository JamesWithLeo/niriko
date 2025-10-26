#!/bin/bash

STATE_FILE="$HOME/.config/waybar/date_format_state"

current=$(cat "$STATE_FILE" 2>/dev/null || echo "numeric")

if [ "$current" = "numeric" ]; then
  echo "word" > "$STATE_FILE"
else
  echo "numeric" > "$STATE_FILE"
fi

# Tell Waybar to refresh this module immediately
pkill -SIGRTMIN+8 waybar
