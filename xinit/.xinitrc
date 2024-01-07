#! /bin/sh
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
# export XDG_SESSION_TYPE="wayland"
export XDG_SESSION_DESKTOP="i3"
export XDG_CURRENT_DESKTOP="i3"
exec i3
