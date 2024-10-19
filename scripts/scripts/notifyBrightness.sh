exactBrightness=$(light)
brightness=$(echo "(${exactBrightness} + 0.5) / 1" | bc)
notify-send "☼ Brightness: ${brightness}%" --hint=string:x-dunst-stack-tag:brightness
