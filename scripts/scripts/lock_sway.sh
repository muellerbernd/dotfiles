#!/usr/bin/env bash

pic="$HOME/wallpapers/rick-and-morty.png"
tmpbg='/tmp/screen.png'

revert() {
  # xset dpms 0 0 0
  rm /tmp/screen.png
}
#
# # trap revert HUP INT TERM
# # poweroff screen after x sec inactivity
# xset dpms 0 0 60
# grim -o eDP-1 $tmpbg
grim -o "$(wlr-randr --json | jq '.[]' | jq '.name' | tail -1| tr -d \")" $tmpbg
# convert -composite $tmpbg $icon -scale 5% -scale 2000% -fill black -colorize 25% -annotate +0+160 "Type Password to Unlock" $lock $tmpbg
# convert -composite $tmpbg $pic -scale 5% -scale 2000% -fill black -colorize 25% -gravity South -geometry -20x1200 $tmpbg
gm convert $tmpbg -scale 10% -scale 1000% $tmpbg
# gm convert $tmpbg -blur 0x8 $tmpbg
# magick convert $tmpbg -filter Gaussian -resize 50% \
#           -define filter:sigma=3.5 -resize 200% $tmpbg
# gm composite -geometry +100+150 $tmpbg $pic $tmpbg
# convert $tmpbg $pic -gravity Center -composite $tmpbg

# gm convert +shade 1x1 $tmpbg $mask
gm composite -tile "$pic" $tmpbg $tmpbg

swaylock -i $tmpbg -F -f -n -l

revert

# vim: set ts=2 sw=2:
