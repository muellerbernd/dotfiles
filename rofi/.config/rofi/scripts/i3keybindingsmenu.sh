#!/bin/bash

rofi_command="rofi -theme themes/listmenu.rasi"

keybindings=$(
    grep -E "^bindsym" $HOME/.config/i3/config $HOME/.config/i3/one_for_all.conf| \
    cut -d" " -f2- | \
    awk '$1 = "<b>"$1"</b>"'
)

echo -e "${keybindings}" | $rofi_command \
    -dmenu \
    -markup-rows  \
    -i \
    -p "i3 Keybindings" \
    -selected-row 0
