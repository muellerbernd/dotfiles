#!/usr/bin/env bash


DIR="$(cd "$(dirname "$0")" && pwd)"
if ! command -v rofi-music-rs &> /dev/null
then
    echo "rofi-music-rs could not be found"
    $DIR/rofi-music
    # exit 1
else
    rofi-music-rs
fi

