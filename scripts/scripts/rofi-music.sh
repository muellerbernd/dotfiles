#!/usr/bin/env bash


if ! command -v rofi-music-rs &> /dev/null
then
    echo "rofi-music-rs could not be found"
    ./rofi-music
    # exit 1
else
    rofi-music-rs
fi

