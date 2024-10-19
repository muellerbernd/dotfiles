#!/usr/bin/env python

import argparse
import json
import os
import subprocess


def node_parsing(j: dict) -> (bool, str):
    try:
        is_sink = j["info"]["props"]["media.class"] == "Audio/Sink"
    except:
        is_sink = False
    return (is_sink, j["id"])


def get_sink_volume(sink_id: str) -> (int, bool):
    outs = os.popen(f"wpctl get-volume {sink_id}").read().replace("\n", "").split(" ")
    volume = float(outs[1]) * 100.0
    is_muted = False
    try:
        is_muted = outs[2] == "[MUTED]"
    except:
        is_muted = False
    print(f"id {sink_id} is_muted {is_muted} volume {volume}")
    return (int(volume), is_muted)


def notify_volume(volume: int):
    os.popen(
        f'notify-send "🔊  Volume: {volume}%" --hint=string:x-dunst-stack-tag:volume'
    ).read()


def notify_mute():
    os.popen(
        f'notify-send "  Volume muted" --hint=string:x-dunst-stack-tag:volume'
    ).read()


def main(args):
    print(args.vol_type)
    dump_output = json.loads(subprocess.getoutput("pw-dump"))
    sink_volumes = []
    sink_muted = []
    for e in reversed(dump_output):
        is_sink, id = node_parsing(e)
        if is_sink:
            match args.vol_type:
                case "up":
                    os.popen(f"wpctl set-volume {id} 1%+").read()
                case "down":
                    os.popen(f"wpctl set-volume {id} 1%-").read()
                case "mute":
                    os.popen(f"wpctl set-mute {id} toggle").read()
                case _:
                    print("unknown")
            volume, is_muted = get_sink_volume(id)
            sink_volumes.append(volume)
            sink_muted.append(is_muted)
    # if sum(sink_muted) == 5 or sum(sink_volumes) == 0:
    #     notify_mute()
    # else:
    #     notify_volume(max(sink_volumes))
    volume, is_muted = get_sink_volume("@DEFAULT_AUDIO_SINK@")
    if is_muted:
        notify_mute()
    else:
        notify_volume(volume)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="controlVolumePipewire",
        description="This Program changes the volume of pipewire sinks",
        # epilog="Text at the bottom of help",
    )
    parser.add_argument(
        "vol_type", choices=["up", "down", "mute"], help="control volume"
    )
    args = parser.parse_args()
    main(args)
