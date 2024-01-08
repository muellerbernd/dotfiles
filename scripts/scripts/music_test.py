#!/usr/bin/env python3

import os
import subprocess

# Checking for changes
output = subprocess.getoutput("pacmd list-sinks").split("\n")
for item in range(0, len(output) - 1):
    if "* index: " in output[item]:
        currentindexname = output[item + 1].replace("name: <", "").strip()[:-1]
        break
output = subprocess.getoutput("pacmd list-sink-inputs")
for item in output.split("\n"):
    if "sink:" in item:
        if currentindexname != item.split("<")[1].split(">")[0]:
            for item in output.split("\n"):
                if "index:" in item:
                    inputindex = item.strip().replace("index: ", "")
                    os.system(
                        "pacmd move-sink-input "
                        + str(inputindex)
                        + " "
                        + str(currentindexname)
                    )
            os.system('notify-send "Source" "Fixed"')
            exit()
