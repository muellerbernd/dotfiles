#!/usr/bin/env bash
# Toggle the laptop keyboard either on or off and notify the user about it

KEYBOARD_STATE=$(swaymsg -t get_inputs | grep "Translated Set 2 keyboard" -A 13 | grep "send_events" | awk '{print $2}')

# Set these to the icons you want to use.
# If they are not found, the notification will still work.
ICON_ENABLE="~/wallpapers/keyboard.png"
ICON_DISABLE="~/wallpapers/nokeyboard.png"

# The display name of the device in the notify-send popup
DEVICE_DISPLAY_NAME="Laptop Keyboard"

function notify_change() {
    if [ -f "$1" ]; then
        notify-send --urgency=low --icon="$1" "$2"
    else
        notify-send --urgency=low "$2"
    fi
}
if [ "$KEYBOARD_STATE" == "\"enabled\"" ]; then
    echo "disable device"
    # device is enabled, so disable it
    sway input "1:1:AT_Translated_Set_2_keyboard" events disabled
    notify_change "$ICON_DISABLE" "$DEVICE_DISPLAY_NAME Disabled"
else
    echo "enable device"
    # device is disabled, so enable it
    sway input "1:1:AT_Translated_Set_2_keyboard" events enabled
    notify_change "$ICON_ENABLE" "$DEVICE_DISPLAY_NAME Enabled"
fi
