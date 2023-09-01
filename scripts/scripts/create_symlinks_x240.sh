#!/bin/sh
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/git/.gitconfig ~/
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/code-templates/ ~/
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/clang-format/.clang-format ~/
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/zsh/x240/.zshrc ~/
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/tmux/.tmux.conf ~/
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/scripts/ ~/
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/code-templates/ ~/
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/i3/x240/config ~/.config/i3
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/i3/one_for_all.conf ~/.config/i3
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/neovim/nvim/ ~/.config
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/polybar/x240/polybar/ ~/.config
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/dunst/ ~/.config
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/rofi/ ~/.config
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/ranger/ ~/.config
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/alacritty/ ~/.config
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/neofetch/ ~/.config
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/calcurse/ ~/.config
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/touchpad_conf/40-libinput.conf /etc/X11/xorg-conf.d

cd ~/Desktop/GitProjects/dotfiles/
stow -t $HOME i3-common -v
stow -t $HOME i3-x240 -v
stow -t $HOME dunst -v
stow -t $HOME rofi -v
stow -t $HOME gitconf -v
stow -t $HOME clang-format -v
stow -t $HOME alacritty -v
stow -t $HOME zsh -v
stow -t $HOME nvim -v
stow -t $HOME tmux -v
stow -t $HOME ranger -v
stow -t $HOME neofetch -v
stow -t $HOME xinit -v

stow -t $HOME code-templates -v
stow -t $HOME scripts -v
stow -t $HOME wallpapers -v

