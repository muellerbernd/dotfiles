#!/bin/sh

case "$1" in
"up")
    gpg --output ./zsh/.zsh_aliases_work --decrypt ./zsh/.zsh_aliases_work.gpg
    gpg --output ./gitconf-work/.gitconfig-job --decrypt ./gitconf-work/.gitconfig-job.gpg
    stow -v -t $HOME i3-common \
        i3-x240 \
        i3status \
        dunst \
        rofi \
        picom \
        gitconf \
        gitconf-work \
        clang-format \
        prettier-format \
        alacritty \
        zsh \
        nvim \
        tmux \
        ranger \
        neofetch \
        zathura \
        latexmk \
        starship \
        xinit \
        gtk-3.0 \
        locale \
        mime-apps \
        code-templates \
        scripts \
        fonts \
        wallpapers
    ;;
"down")
    stow -t $HOME -v -D i3-common \
        i3-x240 \
        i3status \
        dunst \
        rofi \
        picom \
        gitconf \
        gitconf-work \
        clang-format \
        prettier-format \
        alacritty \
        zsh \
        nvim \
        tmux \
        ranger \
        neofetch \
        zathura \
        latexmk \
        starship \
        xinit \
        gtk-3.0 \
        locale \
        mime-apps \
        code-templates \
        scripts \
        fonts \
        wallpapers
    ;;
*)
    notify-send "dotfiles setup unknown argument"
    ;;
esac

