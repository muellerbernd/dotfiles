#!/usr/bin/env python

# inspired by https://gist.github.com/Diaoul/4a33dfec9d80763a7f74ce8086bf5237

import json
import subprocess

MONITOR_MAP = {
    "BNQ BenQ GW2780 ETFAL03748SL0": 1,
    "AU Optronics 0xD291": 2,
}


def get_monitors() -> dict:
    monitors = json.loads(subprocess.getoutput("hyprctl monitors -j"))
    return monitors


def create_workspaces():
    workspaces_json = json.loads(subprocess.getoutput("hyprctl workspaces -j"))
    print(workspaces_json)
    needed_workspaces = [1, 2, 3]
    for i in reversed(needed_workspaces):
    # for i in range(1,11):
        try:
            workspace = list(filter(lambda x: x["id"] == i, workspaces_json))[0]
        except:
            workspace = None
        if workspace is None:
            print(f"workspace {i} does not exist")
            _ = subprocess.getoutput(f"hyprctl keyword workspace {i}, persistent:true")
            _ = subprocess.getoutput(f"hyprctl dispatch workspace {i}")
        else:
            print(f"workspace {i} exists")
            print(workspace)
            _ = subprocess.getoutput(f"hyprctl keyword workspace {i}, persistent:true")
            _ = subprocess.getoutput(f"hyprctl dispatch workspace {i}")


def assign_and_move(monitor_remap: dict):
    for monitor, workspace in monitor_remap.items():
        print(f"Moving workspace {workspace} to {monitor}")
        _ = subprocess.getoutput(
            f"hyprctl keyword workspace '{workspace}, monitor:${monitor}, persistent:true, default:true'"
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
    # activate workspaces 1,2,3
    needed_workspaces = [1, 2]
    for i in reversed(needed_workspaces):
        _ = subprocess.getoutput(f"hyprctl dispatch workspace {i}")


if __name__ == "__main__":
    main()
