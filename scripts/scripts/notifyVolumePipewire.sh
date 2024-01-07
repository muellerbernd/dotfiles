#!/usr/bin/env bash
# notifyVolumePipewire

function get_volume {
    wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}' | awk '{split($0,a,"."); print a[2]}'
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

