#!/bin/bash
# File              : notifyCaps.sh
# Author            : Bernd Müller <bernd@muellerbernd.de>
# Date              : 28.06.2023
msgId="981141"
caps_lock_status=$(xset -q | sed -n 's/^.*Caps Lock:\s*\(\S*\).*$/\1/p')
echo "$caps_lock_status"
dunstify -u low -r "$msgId" "caps lock $caps_lock_status"
# if [ $caps_lock_status == "on" ]; then
#   echo "Caps lock on"
#   dunstify -u low -r "$msgId" "caps lock on"
#   # xdotool key Caps_Lock
# else
#   echo "Caps lock off"
#   dunstify -u low -r "$msgId" "caps lock off"
# fi
