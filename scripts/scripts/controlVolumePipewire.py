#!/usr/bin/env python

import argparse
import json
import subprocess


def node_parsing(j: dict) -> tuple[bool, str]:
    try:
        is_sink = j["info"]["props"]["media.class"] == "Audio/Sink"
    except KeyError:
        is_sink = False
    return is_sink, j["id"]


def get_sink_volume(sink_id: str) -> tuple[float, bool]:
    is_muted = False
    try:
        outs = (
            subprocess.check_output(f"wpctl get-volume {sink_id}", shell=True)
            .decode()
            .strip()
            .split(" ")
        )
        volume = float(outs[1])
        if len(outs) == 3:
            is_muted = outs[2] == "[MUTED]"
    except (subprocess.CalledProcessError, IndexError):
        volume, is_muted = 0, False
    # print(f"id {sink_id} is_muted {is_muted} volume {volume}")
    return volume, is_muted


def notify_volume(volume: int):
    subprocess.run(
        f'notify-send "🔊  Volume: {volume}%" --hint=string:x-dunst-stack-tag:volume',
        shell=True,
    )


def notify_mute():
    subprocess.run(
        f'notify-send "  Volume muted" --hint=string:x-dunst-stack-tag:volume',
        shell=True,
    )


def main(args):
    dump_output = json.loads(subprocess.getoutput("pw-dump"))
    sink_ids = []
    for e in reversed(dump_output):
        is_sink, sid = node_parsing(e)
        if is_sink:
            sink_ids.append(sid)

    default_vol, default_muted = get_sink_volume("@DEFAULT_SINK@")
    target = default_vol
    mute_toggle = False
    if args.vol_type == "up":
        target += 0.01
    elif args.vol_type == "down":
        target -= 0.01
    elif args.vol_type == "mute":
        mute_toggle = True

    if mute_toggle:
        subprocess.run(f"wpctl set-mute @DEFAULT_SINK@ toggle", shell=True)
    else:
        for sid in sink_ids:
            subprocess.run(f"wpctl set-volume {sid} {target}", shell=True)

    default_vol, default_muted = get_sink_volume("@DEFAULT_SINK@")
    if default_muted:
        notify_mute()
    else:
        print(default_vol)
        notify_volume(int(default_vol * 100))


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
