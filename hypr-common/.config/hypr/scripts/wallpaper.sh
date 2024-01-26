#!/usr/bin/env bash

HOSTNAME=$(hostname)

if [[ $HOSTNAME == "mue-p14s" ]]; then
    swaybg -m fill -i ~/wallpapers/work-wallpaper.png
else
    swaybg -m fill -i ~/wallpapers/aot.jpg
fi
