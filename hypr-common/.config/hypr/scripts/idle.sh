#!/usr/bin/env bash
#
exec swayidle -w \
    timeout 300 'notify-send -u critical -t 9000 "Locking Screen in 10 seconds"' \
    timeout 310 '~/.config/hypr/scripts/lock.sh' \
    timeout 500 'hyprctl dispatch dpms off'\
    resume 'hyprctl dispatch dpms on'
