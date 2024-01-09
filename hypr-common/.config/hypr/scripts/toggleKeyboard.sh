#!/usr/bin/env sh

# Set device to be toggled
# HYPRLAND_DEVICE="pxic2642:00-04ca:00b1-touchpad"
HYPRLAND_DEVICE="at-translated-set-2-keyboard"
HYPRLAND_VARIABLE="device:$HYPRLAND_DEVICE:enabled"

if [ -z "$XDG_RUNTIME_DIR" ]; then
  export XDG_RUNTIME_DIR=/run/user/$(id -u)
fi

# Check if device is currently enabled (1 = enabled, 0 = disabled)
DEVICE="$(hyprctl getoption $HYPRLAND_VARIABLE | grep 'int: 1')"

if [ -z "$DEVICE" ]; then
    # if the device is disabled, then enable
    notify-send -u normal "Enabling Keyboard"
    hyprctl keyword $HYPRLAND_VARIABLE true
else
    # if the device is enabled, then disable
    notify-send -u normal "Disabling Keyboard"
    hyprctl keyword $HYPRLAND_VARIABLE false
fi
