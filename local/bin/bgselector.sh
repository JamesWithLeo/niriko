#!/usr/bin/env bash

# Directories
wall_dir="$HOME/Pictures/Wallpaper"
cache_dir="$HOME/.cache/thumbnails/bgselector"

mkdir -p "$wall_dir"
mkdir -p "$cache_dir"

# Generate thumbnails for rofi menu
find "$wall_dir" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | while read -r imagen; do
  filename="$(basename "$imagen")"
  thumb="$cache_dir/$filename"
  if [ ! -f "$thumb" ]; then
    magick convert -strip "$imagen" -thumbnail x540^ -gravity center -extent 262x540 "$thumb"
  fi
done

# Build rofi menu with thumbnails safely
wall_selection=$(find "$wall_dir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | while read -r imagen; do
  filename="$(basename "$imagen")"
  thumb="$cache_dir/$filename"
  echo -en "$filename\x00icon\x1f$thumb\n"
done | rofi -dmenu -config "$HOME/.config/rofi/bgselector.rasi")

# If a wallpaper is selected
if [ -n "$wall_selection" ]; then
  wall_path="$wall_dir/$wall_selection"

  # Set normal wallpaper
  swww img "$wall_path" -t grow --transition-duration 1 --transition-fps 75

  # Generate blurred overview wallpaper
  blurred_wall="$cache_dir/blurred_$wall_selection"
  if [ ! -f "$blurred_wall" ]; then
    magick convert "$wall_path" -blur 0x20 "$blurred_wall"
  fi

  # Set overview/namespace wallpaper
  swww img "$blurred_wall" --namespace overviewbg

  # Update Waybar colors
  sleep 0.2
  colorwaybar "$wall_path"

  exit 0
else
  exit 1
fi
