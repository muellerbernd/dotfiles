#!/bin/sh

min_bat=10
max_bat=95
seconds=5

while true; do
    cur_bat=$(cat /sys/class/power_supply/BAT1/capacity)
    status=$(cat /sys/class/power_supply/BAT1/status)

    if [ $cur_bat -le $min_bat ] && [ "$status" = "Discharging" ]; then
        notify-send "Low Battery Level" "Battery is at $cur_bat%. Please plug in the charger"
    elif [ $cur_bat -ge $max_bat ] && [ "$status" = "Charging" ]; then
        notify-send "High Battery Level" "Battery is at $cur_bat%. Please unplug the charger"
    fi

    sleep $seconds
done
