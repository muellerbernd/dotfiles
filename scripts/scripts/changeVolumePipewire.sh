#!/usr/bin/env bash
# changeVolumePipewire

function get_all_sinks {
    # pulsemixer --list | grep -e 'Sink:' | cut -d":" -f 3 | cut -d"," -f 1
    # pactl list short sinks | cut -f 2
    pw-cli list-objects Node | grep -e 'Sink' -B 11 | grep -m1 "" | awk '{split($0,a,","); print a[1]}' | awk '{print $2}'
}

for sink in $(get_all_sinks); do
    echo "$sink"
    case "$1" in
    "up")
        wpctl set-volume $sink 1%+
        # pulsemixer --id $sink --change-volume +1
        ;;
    "down")
        wpctl set-volume $sink 1%-
        # pulsemixer --id $sink --change-volume -1
        ;;
    "mute")
        wpctl set-mute $sink toggle
        # pulsemixer --id $sink --toggle-mute --get-mute
        ;;
    "*") ;;
    esac
done
