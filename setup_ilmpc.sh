#!/bin/sh

case "$1" in
    "up")
        gpg --output ./zsh/.zsh_aliases_work --decrypt ./zsh/.zsh_aliases_work.gpg
        gpg --output ./gitconf-work/.gitconfig-job --decrypt ./gitconf-work/.gitconfig-job.gpg
        stow -v -t $HOME i3-common \
            i3-ilmpc \
            i3blocks \
            dunst \
            rofi \
            picom \
            gitconf \
            gitconf-work \
            clang-format \
            prettier-format \
            alacritty \
            wezterm \
            zsh \
            nvim \
            tmux \
            ranger \
            neofetch \
            zathura \
            latexmk \
            starship \
            nix \
            fonts \
            xinit \
            locale \
            mime-apps \
            code-templates \
            yazi \
            scripts \
            wallpapers
        ;;
    "down")
        stow -t $HOME -v -D i3-common \
            i3-ilmpc \
            i3blocks \
            dunst \
            rofi \
            picom \
            gitconf \
            gitconf-work \
            clang-format \
            prettier-format \
            yazi \
            alacritty \
            wezterm \
            zsh \
            nvim \
            tmux \
            ranger \
            neofetch \
            zathura \
            latexmk \
            starship \
            nix \
            fonts \
            xinit \
            locale \
            mime-apps \
            code-templates \
            scripts \
            wallpapers
        ;;
    *)
        notify-send "dotfiles setup unknown argument"
        ;;
esac
