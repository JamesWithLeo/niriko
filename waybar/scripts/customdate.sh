#!/bin/bash
# echo " $(date '+%a - %d . %m')"


STATE_FILE="$HOME/.config/waybar/date_format_state"

state=$(cat "$STATE_FILE" 2>/dev/null || echo "numeric")

if [ "$state" = "word" ]; then
echo " $(date '+%a %d.%B')"
  # date '+%a - %d . %B'   # e.g., Mon - 22 . July
else

echo " $(date '+%a %d.%m')"
  # date '+%a - %d . %m'   # e.g., Mon - 22 . 07
fi
