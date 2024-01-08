#!/usr/bin/env python3

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


# def notify_volume():
#     os.popen(
#         "wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}' | awk '{split($0,a,'.'); print a[2]}'"
#     )


def main(args):
    print(args.vol_type)
    dump_output = json.loads(subprocess.getoutput("pw-dump"))
    # print(dump_output)
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
