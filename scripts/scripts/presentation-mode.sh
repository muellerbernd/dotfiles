#!/bin/sh
#
# xrandr --output eDP-1 --primary --mode 1920x1200 --pos 0x0 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-3-1 --off --output DP-3-2 --off --output DP-3-3 --off --output DP-4 --off --output DP-4-1 --off --output DP-4-2 --off --output DP-4-3 --off --output HDMI-1 --off --output VIRTUAL1 --off
#
# xrandr --output HDMI-1 --mode 1920x1080 --output eDP1 --primary --scale-from 1920x1080, mode "default"

# msgId="991051"
# /usr/bin/dunstify -u low -r "$msgId" "presentation mode"

# hdmi_active=$(xrandr |grep ' connected' |grep 'HDMI' |awk '{print $1}')
#
# if [[ $hdmi_active = "HDMI1" ]]
# then
#   # xrandr --output eDP1 --primary --mode 1920x1080 --pos 1920x0 --rotate inverted --output HDMI1 --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
#   xrandr \
#   --fb 4320x1350 \
#   --output HDMI1 --mode 1920x1080 --pos 0x0 --rotate normal --primary --scale 1.25x1.25 \
#   --output eDP1 --mode 1920x1080 --pos 2400x0 --scale 1x1 --rotate inverted
#
# else
#   xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI1 --off --output VIRTUAL1 --off
# fi

# sleep 3
#
#
# status=$(cat /sys/class/drm/card0/*HDMI*/status)
#
# if [ "${status}" = "connected" ]; then
#
# xrandr --output HDMI-A-0 --auto --primary --output eDP --off
#
# else
#
# xrandr --output eDP --auto --primary --output HDMI-A-0 --off
#
# fi

export XAUTHORITY=~/.Xauthority
export DISPLAY=:0

# Get out of town if something errors
set -e

HDMI_STATUS=$(</sys/class/drm/card0/card0-HDMI-A-1/status)
# VGA_STATUS=$(</sys/class/drm/card0/card0-VGA-1/status )

if [ "connected" == "$HDMI_STATUS" ]; then
  /usr/bin/xrandr --output HDMI-1 --auto
  /usr/bin/notify-send --urgency=low -t 5000 "Graphics Update" "HDMI plugged in"
# elif [ "connected" == "$VGA_STAUTS" ]; then
#   /usr/bin/xrandr --output HDMI-1 --off
#   /usr/bin/xrandr --output VGA-1 --left-of LVDS-1 --auto
#     /usr/bin/notify-send --urgency=low -t 5000 "Graphics Update" "VGA plugged in"
else
  /usr/bin/xrandr --output HDMI-1 --off
  /usr/bin/notify-send --urgency=low -t 5000 "Graphics Update" "External monitor disconnected"
  exit
fi

# vim: set ts=2 sw=2:
