#!/usr/bin/env sh

killall -q polybar
# while pgrep -u $UID -x polybar >/dev/null; do sleep 0.01; done
# polybar -c ~/.config/polybar/config.ini main &

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -c ~/.config/polybar/config.ini main &
  done
else
  polybar -c ~/.config/polybar/config.ini main &
fi
