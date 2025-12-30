# Like GNU `make`, but `just` rustier.
# https://just.systems/
# run `just` from this directory to see available commands

HOSTNAME := '$(shell ./get_host.sh)'

# Default command when 'just' is run without arguments
default:
    @just --list

# Generic install/delete targets
install:
    just install-default
    just install-${HOSTNAME}

# Generic delete targets
delete:
    just delete-default
    just delete-${HOSTNAME}

# Default host-specific installation
install-default:
    # gpg --output ./zsh/.zsh_aliases_work --decrypt ./zsh/.zsh_aliases_work.gpg
    gpg --output ./gitconf-work/.gitconfig-job --decrypt ./gitconf-work/.gitconfig-job.gpg
    stow --no-folding --restow -v -t $HOME \
      i3-common \
      niri \
      river \
      mango \
      waybar \
      mako \
      rofi \
      fuzzel \
      gitconf \
      gitconf-work \
      clang-format \
      prettier-format \
      alacritty \
      zsh \
      fish \
      nvim \
      tmux \
      neofetch \
      zathura \
      latexmk \
      starship \
      xinit \
      locale \
      code-templates \
      scripts \
      bin \
      yazi \
      xbindkeys \
      thunar \
      foot \
      ghostty \
      prusa-slicer \
      hypr-common \
      wallpapers \
      mpd-notification

# Default delete targets
delete-default:
    # stow --verbose --target=$$HOME --delete */
    stow --no-folding -v -t $HOME --delete i3-common \
      niri \
      river \
      mango \
      waybar \
      mako \
      rofi \
      fuzzel \
      gitconf \
      gitconf-work \
      clang-format \
      prettier-format \
      alacritty \
      zsh \
      fish \
      nvim \
      tmux \
      neofetch \
      zathura \
      latexmk \
      starship \
      xinit \
      locale \
      code-templates \
      scripts \
      bin \
      yazi \
      xbindkeys \
      thunar \
      foot \
      ghostty \
      prusa-slicer \
      FreeCAD \
      hypr-common \
      wallpapers \
      mpd-notification

[group('Hosts install')]
install-mue-p14s:
    stow --no-folding --restow -v -t $HOME i3-p14s hypr-p14s shikane-p14s

[group('Hosts delete')]
delete-mue-p14s:
    stow --no-folding -v -t $HOME --delete i3-p14s hypr-p14s shikane-p14s

[group('Hosts install')]
install-ammerapad:
    just install-t480

[group('Hosts install')]
install-ilmpad:
    just install-t480

[group('Hosts install')]
install-t480:
    stow --no-folding --restow -v -t $HOME i3-t480 hypr-t480 shikane-t480
    # stow --no-folding --restow -v -t $HOME i3status-rust

[group('Hosts delete')]
delete-t480:
    stow --no-folding -v -t $HOME --delete i3-t480 hypr-t480 shikane-t480
    # stow --no-folding -v -t $HOME --delete i3status-rust

[group('Hosts install')]
install-fw13:
    stow --no-folding --restow -v -t $HOME i3-t480 hypr-t480 shikane-fw13
    # stow --no-folding --restow -v -t $HOME i3status-rust

[group('Hosts delete')]
delete-fw13:
    stow --no-folding -v -t $HOME --delete i3-t480 hypr-t480 shikane-fw13
    # stow --no-folding -v -t $HOME --delete i3status-rust

[group('Hosts install')]
install-x240:
    stow --no-folding --restow -v -t $HOME i3-x240 hypr-t480
    # stow --no-folding --restow -v -t $HOME i3status-rust hypr-t480

[group('Hosts delete')]
delete-x240:
    stow --no-folding -v -t $HOME --delete i3-x240
    # stow --no-folding -v -t $HOME --delete i3status-rust

[group('Hosts install')]
install-biltower:
    stow --no-folding --restow -v -t $HOME i3-biltower hypr-biltower shikane-biltower

[group('Hosts delete')]
delete-biltower:
    stow --no-folding -v -t $HOME --delete i3-biltower hypr-biltower shikane-biltower

[group('Hosts install')]
install-EIS-machine:
    stow --no-folding --restow -v -t $HOME i3-eistower

[group('Hosts delete')]
delete-EIS-machine:
    stow --no-folding -v -t $HOME --delete i3-eistower
