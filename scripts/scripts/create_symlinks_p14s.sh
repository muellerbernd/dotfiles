#!/bin/sh
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/code-templates/ ~/
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/clang-format/.clang-format ~/
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/zsh/t540p/.zshrc ~/
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/tmux/.tmux.conf ~/
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/scripts/ ~/
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/code-templates/ ~/
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/i3/t540p/config ~/.config/i3/config
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/i3/one_for_all.conf ~/.config/i3
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/neovim/nvim/ ~/.config
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/polybar/t540p/polybar/ ~/.config
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/dunst/ ~/.config
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/rofi/ ~/.config
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/ranger/ ~/.config
# ln -sfn ~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/alacritty/ ~/.config

cd ~/Desktop/GitProjects/dotfiles/
stow -t $HOME i3-common -v
stow -t $HOME i3-p14s -v
stow -t $HOME dunst -v
stow -t $HOME picom -v
stow -t $HOME rofi -v
stow -t $HOME clang-format -v
stow -t $HOME prettier-format -v
stow -t $HOME alacritty -v
stow -t $HOME nvim -v
stow -t $HOME tmux -v
stow -t $HOME ranger -v
stow -t $HOME neofetch -v
stow -t $HOME zathura -v
stow -t $HOME zsht540p -v
stow -t $HOME latexmk -v
stow -t $HOME starship -v
stow -t $HOME fonts -v
stow -t $HOME gtk-3.0 -v
stow -t $HOME locale -v
stow -t $HOME mime-apps -v

stow -t $HOME code-templates -v
stow -t $HOME scripts -v
stow -t $HOME wallpapers -v
