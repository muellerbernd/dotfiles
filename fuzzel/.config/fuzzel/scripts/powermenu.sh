#!/usr/bin/env bash

set -e
set -u

# CMDs
uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown="shutdown"
reboot="reboot"
lock="lock screen"
suspend="suspend"
hibernate="hibernate"
# logout="\uf842 logout"
logout="logout"
yes='yes'
no='no'

# fuzzel CMD
fuzzel_cmd() {
    fuzzel -D no --dmenu \
        -p "Uptime: $uptime"
}

# Confirmation CMD
confirm_cmd() {
    fuzzel --dmenu -p 'Confirmation'
}

# Ask for confirmation
confirm_exit() {
    echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to fuzzel dmenu
run_fuzzel() {
    echo -e "$shutdown\n$reboot\n$lock\n$suspend\n$hibernate\n$logout" | fuzzel_cmd
}

run_lock_cmd() {
    if [[ "$XDG_CURRENT_DESKTOP" == 'i3' ]]; then
        ~/scripts/lock.sh
    elif [[ "$XDG_CURRENT_DESKTOP" == 'none+i3' ]]; then
        ~/scripts/lock.sh
    elif [[ "$XDG_CURRENT_DESKTOP" == 'sway' ]]; then
        ~/scripts/lock_sway.sh
    elif [[ "$XDG_CURRENT_DESKTOP" == 'Hyprland' ]]; then
        # ~/.config/hypr/scripts/lock.sh
        hyprlock
    elif [[ "$XDG_CURRENT_DESKTOP" == 'River' ]]; then
        # ~/.config/hypr/scripts/lock.sh
        hyprlock
    fi
}

# Execute Command
run_cmd() {
    selected="$(confirm_exit)"
    if [[ "$selected" == "$yes" ]]; then
        if [[ $1 == '--shutdown' ]]; then
            # tmux kill-server
            systemctl poweroff
        elif [[ $1 == '--reboot' ]]; then
            # tmux kill-server
            systemctl reboot
        elif [[ $1 == '--suspend' ]]; then
            # mpc -q pause
            # amixer set Master mute
            # dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause
            # playerctl pause
            # run_lock_cmd
            systemctl suspend
        elif [[ $1 == '--hibernate' ]]; then
            # mpc -q pause
            # amixer set Master mute
            # dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause
            # playerctl pause
            # run_lock_cmd
            systemctl hibernate
        elif [[ $1 == '--logout' ]]; then
            if [[ "$XDG_CURRENT_DESKTOP" == 'i3' ]]; then
                i3-msg exit
            elif [[ "$XDG_CURRENT_DESKTOP" == 'sway' ]]; then
                sway-msg exit
            elif [[ "$XDG_CURRENT_DESKTOP" == 'Hyprland' ]]; then
                hyprctl dispatch exit
            elif [[ "$XDG_CURRENT_DESKTOP" == 'niri' ]]; then
                niri msg action quit
            elif [[ "$XDG_CURRENT_DESKTOP" == 'river' ]]; then
                riverctl exit
            fi
        fi
    else
        exit 0
    fi
}

# Actions
chosen="$(run_fuzzel)"
case ${chosen} in
    $shutdown)
        run_cmd --shutdown
        ;;
    $reboot)
        run_cmd --reboot
        ;;
    $lock)
        loginctl lock-session
        # sh ~/scripts/lock.sh
        ;;
    $suspend)
        run_cmd --suspend
        ;;
    $hibernate)
        run_cmd --hibernate
        ;;
    $logout)
        run_cmd --logout
        ;;
esac
