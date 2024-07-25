#!/usr/bin/env bash

pipe=/tmp/laptopKeyboardState
target=/sys/devices/platform/i8042/serio0/input/input0/inhibited

toggle_keyboard() {
    if [ "$1" = "0" ]; then
        notify-send -u normal "Keyboard disabled"
        echo 1 >"$pipe"
    else
        notify-send -u normal "Keyboard enabled"
        echo 0 >"$pipe"
    fi
}

toggle_keyboard $(cat $target)
# if [  $(cat $target) = 0 ]; then
#     disable_keyboard
# else
#     enable_keyboard
# fi

# # Toggle the laptop keyboard either on or off and notify the user about it
#
# # Device name can be found by typing this command: xinput list --name-only
# DEVICE_NAME="AT Translated Set 2 keyboard"
# DEVICE_ID=$(xinput list | grep "Translated Set 2 keyboard" | awk '{ gsub(/[[:alpha:]]|[[:punct:]]/," ")}1' | awk  '{print $2}')
# MASTER_ID=$(xinput list | grep "Virtual core keyboard" | awk '{ gsub(/[[:alpha:]]|[[:punct:]]/," ")}1' | awk  '{print $1}')
# # The display name of the device in the notify-send popup
# DEVICE_DISPLAY_NAME="Laptop Keyboard"
#
# # Set these to the icons you want to use.
# # If they are not found, the notification will still work.
# ICON_ENABLE="~/wallpapers/keyboard.png"
# ICON_DISABLE="~/wallpapers/nokeyboard.png"
#
# function xinput_set_prop() {
#     echo "device id $DEVICE_ID"
#     echo "master id $MASTER_ID"
#     # xinput set-prop "$DEVICE_ID" "Device Enabled" $1
#     if [ $1 -eq 1 ]; then
#         echo "1"
#         # xinput enable "$DEVICE_NAME"
#         xinput reattach "$DEVICE_ID" "$MASTER_ID"
#     else
#         echo "2"
#         xinput float "$DEVICE_ID"
#         # xinput disable "$DEVICE_NAME"
#     fi
# }
#
# function notify_change() {
#         if [ -f "$1" ]; then
#                 notify-send --urgency=low --icon="$1" "$2"
#         else
#                 notify-send --urgency=low "$2"
#         fi
# }
#
# # Returns 1 if device is enabled, 0 if disabled
# # is_enabled=$(xinput list-props "$DEVICE_NAME" | grep "Device Enabled" | awk '{ print $4 }' | sed 's/[^0-9]*//g')
# is_enabled=$(xinput list | grep "$DEVICE_NAME" | grep -Po "floating")
# echo "$is_enabled"
#
# # if [ $is_enabled -eq 1 ]; then
# if [ "$is_enabled" != "floating" ]; then
#         echo "disable device"
#         # device is enabled, so disable it
#         xinput_set_prop 0
#         notify_change "$ICON_DISABLE" "$DEVICE_DISPLAY_NAME Disabled"
# else
#         echo "enable device"
#         # device is disabled, so enable it
#         xinput_set_prop 1
#         notify_change "$ICON_ENABLE" "$DEVICE_DISPLAY_NAME Enabled"
# fi
