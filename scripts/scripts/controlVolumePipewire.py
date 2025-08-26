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
    sink_ids = []
    # First, collect all sink IDs and apply requested operation to each
    for e in reversed(dump_output):
        is_sink, sid = node_parsing(e)
        if is_sink:
            sink_ids.append(sid)
            if args.vol_type == "up":
                os.popen(f"wpctl set-volume {sid} 1%+").read()
            elif args.vol_type == "down":
                os.popen(f"wpctl set-volume {sid} 1%-").read()
            elif args.vol_type == "mute":
                os.popen(f"wpctl set-mute {sid} toggle").read()
            else:
                print("unknown")

    # Synchronize all sinks to the final volume of the default sink
    default_vol, default_muted = get_sink_volume("@DEFAULT_AUDIO_SINK@")
    target = default_vol

    for sid in sink_ids:
        # Set to the target absolute volume
        os.popen(f"wpctl set-volume {sid} {target}%").read()
        # If default is muted, also mute the others to follow
        if default_muted:
            os.popen(f"wpctl set-mute {sid} toggle").read()

    if default_muted:
        notify_mute()
    else:
        notify_volume(target)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="controlVolumePipewire",
        description="This Program changes the volume of pipewire sinks",
    )
    parser.add_argument(
        "vol_type", choices=["up", "down", "mute"], help="control volume"
    )
    args = parser.parse_args()
    main(args)
