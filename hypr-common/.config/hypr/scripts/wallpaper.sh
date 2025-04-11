#!/usr/bin/env bash

host=$(hostname)
case $host in
"fw13")
    wallpaper=$HOME/wallpapers/framework-explode.jpeg
    ;;
*)
    wallpaper=$HOME/wallpapers/black-hole.png
    ;;
esac

swaybg --image "$wallpaper" --mode fill &
