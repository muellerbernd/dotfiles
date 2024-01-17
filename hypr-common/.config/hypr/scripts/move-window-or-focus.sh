#! /usr/bin/env sh

action=$1; shift
dir=$1; shift

is_first() {
    hyprctl activewindow -j | jq -e ".address == .grouped[0] or .grouped == []"
}

is_last() {
    hyprctl activewindow -j | jq -e ".address == .grouped[-1] or .grouped == []"
}

is_floating() {
    hyprctl activewindow -j | jq -e ".floating"
}

case "$action $dir" in
    "move u")
        hyprctl dispatch movewindoworgroup u
        ;;
    "move d")
        hyprctl dispatch movewindoworgroup d
        ;;
    "move l")
        if ! is_first; then
            hyprctl dispatch movegroupwindow b
        else
            hyprctl dispatch movewindoworgroup l
        fi
        ;;
    "move r")
        if ! is_last; then
            hyprctl dispatch movegroupwindow f
        else
            hyprctl dispatch movewindoworgroup r
        fi
        ;;
    "focus l")
        if ! is_first; then
            hyprctl dispatch changegroupactive b
        else
            hyprctl dispatch movefocus l
        fi
        ;;
    "focus r")
        if ! is_last; then
            hyprctl dispatch changegroupactive f
        else
            hyprctl dispatch movefocus r
        fi
        ;;
esac
