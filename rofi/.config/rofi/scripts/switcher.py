#!/usr/bin/env python

# hyprctl dispatch focuswindow address:$(hyprctl -j clients | jq -r '.[] | select(.class=="firefox") | .address')

import argparse
import json
import subprocess


def get_windows() -> dict:
    windows = json.loads(subprocess.getoutput("hyprctl clients -j"))
    return windows

# Ask for confirmation
# def confirm():
#     subprocess.getoutput('echo -e "$yes\n$no" | rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
#         -theme-str 'mainbox {children: [ "message", "listview" ];}' \
#         -theme-str 'listview {columns: 2; lines: 1;}' \
#         -theme-str 'element-text {horizontal-align: 0.5;}' \
#         -theme-str 'textbox {horizontal-align: 0.5;}' \
#         -dmenu \
#         -p 'Confirmation'')

def main():
    # Instantiate the parser
    parser = argparse.ArgumentParser(description='Optional app description')
    # Required positional argument
    parser.add_argument('drun', type=str,
                    help='A required integer positional argument')
    args = parser.parse_args()
    print(args.drun)

    windows = get_windows()
    # print(windows)
    # out = subprocess.getoutput("rofi -show drun -run-command 'echo {cmd}'")
    # print(out)


if __name__ == "__main__":
    main()
