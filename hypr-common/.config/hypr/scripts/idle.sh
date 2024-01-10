#!/usr/bin/env bash

swayidle -w \
    timeout 300 'notify-send -u critical -t 9000 "Locking Screen in 10 seconds"' \
    timeout 310 'hyprctl dispatch exec ~/.config/hypr/scripts/lock.sh' \
    timeout 500 'hyprctl dispatch dpms off'\
    resume 'hyprctl dispatch dpms on'
