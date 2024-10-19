#!/usr/bin/env bash
msgId="981141"

caps_lock_status=$(cat /sys/class/leds/input0::capslock/brightness)

if [ $caps_lock_status == "1" ]; then
  notify-send "CAPS" --hint=string:x-dunst-stack-tag:caps
else
  notify-send "CAPS OFF" --hint=string:x-dunst-stack-tag:caps
fi
