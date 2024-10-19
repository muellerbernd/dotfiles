#!/usr/bin/env bash
# notifyVolumePipewire

function get_volume {
    wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}' | awk '{split($0,a,"."); print a[2]}'
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off
}

# send_notification
volume=$(get_volume)
retval=$(is_mute)
if [ "$retval" != "" ]
then
    notify-send "  Volume muted" --hint=string:x-dunst-stack-tag:volume
else
    notify-send "🔊  Volume: ${volume}%" --hint=string:x-dunst-stack-tag:volume
fi

