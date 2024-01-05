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
	stow --restow -v -t $$HOME i3-p14s

delete-mue-p14s:
	stow -v -t $$HOME --delete i3-p14s

install-t480:
	stow --restow -v -t $$HOME i3-t480

delete-t480:
	stow -v -t $$HOME --delete i3-t480

install-x240:
	stow --restow -v -t $$HOME i3-x240

delete-x240:
	stow -v -t $$HOME --delete i3-x240

install-biltower:
	stow --restow -v -t $$HOME i3-biltower

delete-biltower:
	stow -v -t $$HOME --delete i3-biltower

install-eis-machine:
	stow --restow -v -t $$HOME i3-eistower

delete-eis-machine:
	stow -v -t $$HOME --delete i3-eistower
