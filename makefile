HOSTNAME = $(shell hostname)

ifndef HOSTNAME
	$(error Hostname unknown)
endif

install:
	make install-default
	make install-${HOSTNAME}

delete:
	make delete-default
	make delete-${HOSTNAME}

install-default:
	gpg --output ./zsh/.zsh_aliases_work --decrypt ./zsh/.zsh_aliases_work.gpg
	gpg --output ./gitconf-work/.gitconfig-job --decrypt ./gitconf-work/.gitconfig-job.gpg
	stow --restow -v -t $$HOME i3-common \
		sway-common \
		dunst \
		rofi \
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
		fonts \
		xinit \
		locale \
		mime-apps \
		code-templates \
		scripts \
		joshuto \
		yazi \
		xbindkeys \
		thunar \
		wallpapers

delete-default:
	# stow --verbose --target=$$HOME --delete */
	stow -v -t $$HOME --delete i3-common \
		sway-common \
		dunst \
		rofi \
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
		fonts \
		xinit \
		locale \
		mime-apps \
		code-templates \
		scripts \
		joshuto \
		yazi \
		xbindkeys \
		thunar \
		wallpapers

install-mue-p14s:
	stow --restow -v -t $$HOME i3-p14s sway-p14s

delete-mue-p14s:
	stow -v -t $$HOME --delete i3-p14s sway-p14s

install-t480:
	stow --restow -v -t $$HOME i3-t480 sway-t480
	stow --restow -v -t $$HOME i3status-rust

delete-t480:
	stow -v -t $$HOME --delete i3-t480 sway-t480
	stow -v -t $$HOME --delete i3status-rust

install-x240:
	stow --restow -v -t $$HOME i3-x240
	stow --restow -v -t $$HOME i3status-rust

delete-x240:
	stow -v -t $$HOME --delete i3-x240
	stow -v -t $$HOME --delete i3status-rust

install-biltower:
	stow --restow -v -t $$HOME i3-biltower sway-biltower

delete-biltower:
	stow -v -t $$HOME --delete i3-biltower sway-biltower

install-EIS-machine:
	stow --restow -v -t $$HOME i3-eistower

delete-EIS-machine:
	stow -v -t $$HOME --delete i3-eistower
