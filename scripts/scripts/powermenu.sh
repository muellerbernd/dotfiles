#! /bin/sh

# chosen=$(printf "  Power Off\n  Restart\n  Lock" | rofi -dmenu -i -theme-str '@import "power.rasi"')
chosen=$(printf "  Power Off\n  Restart\n  Lock" | rofi -dmenu -i)

case "$chosen" in
    "  Power Off") poweroff ;;
    "  Restart") reboot ;;
    "  Lock") slock ;;
    *) exit 1 ;;
esac
