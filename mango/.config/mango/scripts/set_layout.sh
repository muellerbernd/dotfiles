#!/usr/bin/env bash

# get all monitors
monitors=$(mmsg -O)

# Get the first monitor (first line)
first_monitor=$(echo "$monitors" | head -n 1)

# get layout for monitor
layout=$(mmsg -g -l -o "$first_monitor" | awk '{print$2}')

echo "Iterating over monitors:"
echo "$monitors" | while read -r monitor; do
    mmsg -s -l "$layout" -o "$monitor"
done

declare -A map=(
  ["S"]="scroller"
  ["T"]="tile"
  ["RT"]="right tile"
  ["LT"]="left tile"
  ["G"]="grid"
  ["M"]="monocle"
  ["K"]="deck"
  ["VS"]="vertical scroller"
  ["VT"]="vertical tile"
  ["CT"]="center tile"
)

name="${map[$layout]:-$layout}"

notify-send "Set Layout: $name for all monitors"
