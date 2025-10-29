#!/usr/bin/env bash

# get selected monitor
monitor=$(mmsg -g | grep "selmon 1" | awk '{print$1}')
echo "$monitor"
# get layout for monitor
layout=$(mmsg -g -l -o "$monitor" | awk '{print$2}')
echo "$layout"

declare -A swap=( ["S"]="VS" ["VS"]="S" ["T"]="VT" ["VT"]="T" )
mapped=${swap[$layout]:-$layout}
echo "$mapped"

mmsg -s -l "$mapped" -o "$monitor"

