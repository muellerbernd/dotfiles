#!/bin/sh

# Only exported variables can be used within the timer's command.
# export DISPLAYS=("$(xrandr | awk '/ connected/{print $1}')")
# export ARR=($DISPLAYS)
# echo ${ARR[@]}
# export PRIMARY_DISPLAY=${ARR[0]}
# echo $PRIMARY_DISPLAY
# export SECONDARY_DISPLAY=${ARR[0]}
# x=${#ARR[@]}
# echo $x
# if ((x > 1))
# then
# export SECONDARY_DISPLAY=${ARR[1]}
# fi
# echo $SECONDARY_DISPLAY

# Run xidlehook
xidlehook \
  --not-when-fullscreen \
  --not-when-audio \
  --timer 600 \
    '$HOME/scripts/lock.sh' \
    'xset dpms force on' \
  --timer 120 \
    'xset dpms force off' \
    'xset dpms force on' \
