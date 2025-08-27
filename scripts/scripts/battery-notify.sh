#!/bin/sh

min_bat=10
seconds=5

# Detect the first available battery path
bat_path=""
for b in /sys/class/power_supply/BAT*; do
  if [ -r "$b/capacity" ] && [ -r "$b/status" ]; then
    bat_path="$b"
    break
  fi
done

if [ -z "$bat_path" ]; then
  echo "No battery found" >&2
  exit 1
fi

while true; do
  cur_bat=$(cat "$bat_path/capacity")
  status=$(cat "$bat_path/status")

  if [ "$cur_bat" -le "$min_bat" ] && [ "$status" = "Discharging" ]; then
    notify-send "Low Battery Level" "Battery is at ${cur_bat}%. Please plug in the charger"
  fi

  sleep "$seconds"
done
