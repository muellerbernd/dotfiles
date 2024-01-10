#!/usr/bin/env bash
msgId="981141"

caps_lock_status=$(cat /sys/class/leds/input0::capslock/brightness)

if [ $caps_lock_status == "1" ]; then
  dunstify -u low -r "$msgId" "caps lock on"
else
  dunstify -u low -r "$msgId" "caps lock off"
fi
