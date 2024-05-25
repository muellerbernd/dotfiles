#!/usr/bin/env bash

# pic="$HOME/wallpapers/rick-and-morty.png"
# lock="$HOME/wallpapers/lock.png"
# tmpbg='/tmp/screen.png'
#
# revert() {
#     # xset dpms 0 0 0
#     rm /tmp/screen.png
# }
# #
# # # trap revert HUP INT TERM
# # # poweroff screen after x sec inactivity
# # xset dpms 0 0 60
# grim $tmpbg
# # convert -composite $tmpbg $icon -scale 5% -scale 2000% -fill black -colorize 25% -annotate +0+160 "Type Password to Unlock" $lock $tmpbg
# # convert -composite $tmpbg $pic -scale 5% -scale 2000% -fill black -colorize 25% -gravity South -geometry -20x1200 $tmpbg
# gm convert $tmpbg -scale 10% -scale 1000%  $tmpbg
# # gm convert $tmpbg -blur 0x8 $tmpbg
# # magick convert $tmpbg -filter Gaussian -resize 50% \
# #           -define filter:sigma=3.5 -resize 200% $tmpbg
# # gm composite -geometry +100+150 $tmpbg $pic $tmpbg
# # convert $tmpbg $pic -gravity Center -composite $tmpbg
#
# # gm convert +shade 1x1 $tmpbg $mask
# gm composite -tile $pic $tmpbg $tmpbg
#
# swaylock -i $tmpbg -e -f -n
#
# revert
# pidof hyprlock || hyprlock
hyprlock
hyprctl dispatch movefocus r
hyprctl dispatch movefocus l

# vim: set ts=2 sw=2:
