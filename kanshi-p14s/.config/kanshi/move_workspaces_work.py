#!/usr/bin/env python

import json
import subprocess

MONITOR_MAP = {
    "Dell Inc. DELL U2415 7MT0196C30JU": 2,
    "Dell Inc. DELL U2415 7MT018B3062L": 1,
    "AU Optronics 0xD291": 3,
}


def get_monitors() -> dict:
    monitors = json.loads(subprocess.getoutput("hyprctl monitors -j"))
    return monitors


def create_workspaces():
    workspaces_json = json.loads(subprocess.getoutput("hyprctl workspaces -j"))
    print(workspaces_json)
    needed_workspaces = [1, 2, 3]
    for i in reversed(needed_workspaces):
        workspace = list(filter(lambda x: x["id"] == i, workspaces_json))[0]
        if workspace is None:
            print(f"workspace {i} does not exist")
            _ = subprocess.getoutput(f"hyprctl dispatch workspace {i}")
            _ = subprocess.getoutput(f"hyprctl dispatch workspaceopt persistent")
        else:
            print(f"workspace {i} exists")
            _ = subprocess.getoutput(f"hyprctl dispatch workspace {i}")
            _ = subprocess.getoutput(f"hyprctl dispatch workspaceopt persistent")
        _ = subprocess.getoutput(f"hyprctl dispatch workspace {i}")


def assign_and_move(monitor_remap: dict):
    for monitor, workspace in monitor_remap.items():
        print(f"Moving workspace {workspace} to {monitor}")
        _ = subprocess.getoutput(
            f"hyprctl keyword workspace '{workspace}, monitor:${monitor}'"
        )
        _ = subprocess.getoutput(
            f"hyprctl dispatch moveworkspacetomonitor {workspace} {monitor}"
        )


def main():
    monitors: dict = get_monitors()
    print(monitors)
    monitor_remap: dict = {}
    for m in monitors:
        monitor_name = m["name"]
        monitor_desc = m["description"].split(" (")[0]
        monitor_remap[monitor_name] = MONITOR_MAP[monitor_desc]
    print(monitor_remap)
    create_workspaces()
    assign_and_move(monitor_remap)


if __name__ == "__main__":
    main()
