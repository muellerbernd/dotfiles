#!/usr/bin/env bash
# changeVolume

function get_all_sinks {
    # pulsemixer --list | grep -e 'Sink:' | cut -d":" -f 3 | cut -d"," -f 1
    pactl list short sinks | cut -f 2
}

for sink in $(get_all_sinks); do
    echo "$sink"
    case "$1" in
    "up")
        pactl set-sink-volume $sink +1%
        # pulsemixer --id $sink --change-volume +1
        ;;
    "down")
        pactl set-sink-volume $sink -1%
        # pulsemixer --id $sink --change-volume -1
        ;;
    "mute")
        pactl set-sink-mute $sink toggle
        # pulsemixer --id $sink --toggle-mute --get-mute
        ;;
    "*") ;;
    esac
done
