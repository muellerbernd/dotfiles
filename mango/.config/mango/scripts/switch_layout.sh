#!/usr/bin/env bash

mmsg switch_layout
# get selected monitor
monitor=$(mmsg -g | grep "selmon 1" | awk '{print$1}')
echo "$monitor"
# get layout for monitor
layout=$(mmsg -g -l -o "$monitor" | awk '{print$2}')
echo "old: $layout"

case "$layout" in
  S)  layout="T" ;;
  T)  layout="VS" ;;
  # RT) layout="G" ;;
  # G)  layout="M" ;;
  # M)  layout="K" ;;
  # K)  layout="VS" ;;
  VS) layout="VT" ;;
  VT) layout="S" ;;
  # CT) layout="S" ;;
  *)   layout="$layout" ;;  # unchanged if unknown
esac

echo "new: $layout"

mmsg -s -l "$layout" -o "$monitor"

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
echo "$name"

notify-send "New Layout: $name"

