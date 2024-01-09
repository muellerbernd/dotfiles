exec swayidle -w \
    timeout 300 'notify-send -u critical -t 9000 "Locking Screen in 10 seconds"' \
    timeout 310 '~/scripts/lock_sway.sh' \
    timeout 500 'hyprctl dispatch dpms off'\
    resume 'hyprctl dispatch dpms on'
