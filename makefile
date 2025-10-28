HOSTNAME = $(shell ./get_host.sh)

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
	# gpg --output ./zsh/.zsh_aliases_work --decrypt ./zsh/.zsh_aliases_work.gpg
	gpg --output ./gitconf-work/.gitconfig-job --decrypt ./gitconf-work/.gitconfig-job.gpg
	stow --no-folding --restow -v -t $$HOME i3-common \
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
		mime-apps \
		foot \
		ghostty \
		prusa-slicer \
		FreeCAD \
		hypr-common \
		wallpapers
		# fonts \

delete-default:
	# stow --verbose --target=$$HOME --delete */
	stow --no-folding -v -t $$HOME --delete i3-common \
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
		mime-apps \
		foot \
		ghostty \
		prusa-slicer \
		FreeCAD \
		hypr-common \
		wallpapers
		# fonts \

install-mue-p14s:
	stow --no-folding --restow -v -t $$HOME i3-p14s hypr-p14s shikane-p14s

delete-mue-p14s:
	stow --no-folding -v -t $$HOME --delete i3-p14s hypr-p14s shikane-p14s

install-ammerapad:
	make install-t480

install-ilmpad:
	make install-t480

install-t480:
	stow --no-folding --restow -v -t $$HOME i3-t480 hypr-t480 shikane-t480
	# stow --no-folding --restow -v -t $$HOME i3status-rust

delete-t480:
	stow --no-folding -v -t $$HOME --delete i3-t480 hypr-t480 shikane-t480
	# stow --no-folding -v -t $$HOME --delete i3status-rust

install-fw13:
	stow --no-folding --restow -v -t $$HOME i3-t480 hypr-t480 shikane-fw13
	# stow --no-folding --restow -v -t $$HOME i3status-rust

delete-fw13:
	stow --no-folding -v -t $$HOME --delete i3-t480 hypr-t480 shikane-fw13
	# stow --no-folding -v -t $$HOME --delete i3status-rust

install-x240:
	stow --no-folding --restow -v -t $$HOME i3-x240 hypr-t480
	# stow --no-folding --restow -v -t $$HOME i3status-rust hypr-t480

delete-x240:
	stow --no-folding -v -t $$HOME --delete i3-x240
	# stow --no-folding -v -t $$HOME --delete i3status-rust

install-biltower:
	stow --no-folding --restow -v -t $$HOME i3-biltower hypr-biltower shikane-biltower

delete-biltower:
	stow --no-folding -v -t $$HOME --delete i3-biltower hypr-biltower shikane-biltower

install-EIS-machine:
	stow --no-folding --restow -v -t $$HOME i3-eistower

delete-EIS-machine:
	stow --no-folding -v -t $$HOME --delete i3-eistower
