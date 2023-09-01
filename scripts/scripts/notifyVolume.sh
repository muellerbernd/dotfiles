#!/bin/bash
# notifyVolume

function get_volume {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off
}

# send_notification
msgId="991049"
volume=$(get_volume)
retval=$(is_mute)
if [ "$retval" != "" ]
then
    dunstify -a "changeVolume" -u low -r "$msgId" "  Volume muted"
else
    dunstify -a "changeVolume" -u low -r "$msgId" \
        "🔊  Volume: ${volume}%"
fi

