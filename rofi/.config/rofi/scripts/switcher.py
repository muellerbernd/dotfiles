#!/usr/bin/env python

import argparse
import json
import os
import subprocess


def get_windows() -> dict:
    windows = json.loads(subprocess.getoutput("hyprctl clients -j"))
    return windows


def main():
    # Instantiate the parser
    parser = argparse.ArgumentParser(description="Optional app description")
    # Required positional argument
    parser.add_argument("drun", type=str, help="A required integer positional argument")
    args = parser.parse_args()
    # print(args.drun)

    windows = get_windows()
    # config
    rofiOption = ""

    window_list: dict = {}
    for window in windows:
        address = window["address"]
        # c = window["class"]
        # title = window["title"]
        # workspace = window["workspace"]
        wanted_keys = ["class", "title", "workspace"]  # The keys you want
        window_subset = dict((k, window[k]) for k in wanted_keys if k in window)
        window_list[address] = str(window_subset)
    # config
    rofiOption = ""
    # preparing menu
    # print(window_list.values())
    menu = '"' + "\n".join(window_list.values()) + '"'

    # displaying menu
    try:
        choice: str = os.popen(
            "echo " + menu + ' | rofi -dmenu -i -p "Select Windows" ' + rofiOption
        ).read()[:-1]
        addr: list = list(window_list.keys())[list(window_list.values()).index(choice)]
        workspace: str = eval(choice)["workspace"]["name"]
        if "special" in workspace:
            special_ws = workspace.split(":")[1]
            os.system(
                f"hyprctl dispatch focuswindow address:{addr} && hyprctl dispatch togglespecialworkspace {special_ws}"
            )
        else:
            os.system(f"hyprctl dispatch focuswindow address:{addr}")
    except Exception as e:
        print(e)


if __name__ == "__main__":
    main()
