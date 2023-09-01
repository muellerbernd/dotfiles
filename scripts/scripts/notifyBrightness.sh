msgId="981141"
exactBrightness=$(light)
brightness=$(echo "(${exactBrightness} + 0.5) / 1" | bc)
dunstify -a "changeBrightness" -u low -r "$msgId" \
"☼ Brightness: ${brightness}%"
