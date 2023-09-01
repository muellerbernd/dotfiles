#!/bin/sh
for x in /sys/devices/system/cpu/cpu[0-16]*/online; do
    echo 0 >"$x"
done
