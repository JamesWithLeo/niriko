#!/bin/bash
STATE_FILE="$HOME/.charge_mode_state"

if [ -f "$STATE_FILE" ] && grep -q "full" "$STATE_FILE"; then
    asusctl -c 60
    notify-send -u low "Charge Limit Changed! [60%]"
    echo "limited" > "$STATE_FILE"
else
    asusctl -o
    notify-send -u low "Charge Limit Changed! [100%]"
    echo "full" > "$STATE_FILE"
fi
