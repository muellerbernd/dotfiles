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
	gpg --output ./zsh/.zsh_aliases_work --decrypt ./zsh/.zsh_aliases_work.gpg
	gpg --output ./gitconf-work/.gitconfig-job --decrypt ./gitconf-work/.gitconfig-job.gpg
	stow --no-folding --restow -v -t $$HOME i3-common \
		sway-common \
		niri \
		hypr-common \
		jay \
		river \
		waybar \
		yambar \
		dunst \
		mako \
		rofi \
		fuzzel \
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
		code-templates \
		scripts \
		joshuto \
		yazi \
		xbindkeys \
		thunar \
		mime-apps \
		foot \
		contour \
		wallpapers

delete-default:
	# stow --verbose --target=$$HOME --delete */
	stow --no-folding -v -t $$HOME --delete i3-common \
		sway-common \
		hypr-common \
		jay \
		river \
		waybar \
		yambar \
		dunst \
		mako \
		rofi \
		fuzzel \
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
		code-templates \
		scripts \
		joshuto \
		yazi \
		xbindkeys \
		thunar \
		mime-apps \
		foot \
		contour \
		wallpapers

install-mue-p14s:
	stow --no-folding --restow -v -t $$HOME i3-p14s sway-p14s hypr-p14s kanshi-p14s shikane-p14s

delete-mue-p14s:
	stow --no-folding -v -t $$HOME --delete i3-p14s sway-p14s hypr-p14s kanshi-p14s shikane-p14s

install-ammerapad:
	make install-t480

install-ilmpad:
	make install-t480

install-t480:
	stow --no-folding --restow -v -t $$HOME i3-t480 sway-t480 hypr-t480 kanshi-t480 shikane-t480
	stow --no-folding --restow -v -t $$HOME i3status-rust

delete-t480:
	stow --no-folding -v -t $$HOME --delete i3-t480 sway-t480 hypr-t480 kanshi-t480 shikane-t480
	stow --no-folding -v -t $$HOME --delete i3status-rust

install-x240:
	stow --no-folding --restow -v -t $$HOME i3-x240 hypr-t480
	stow --no-folding --restow -v -t $$HOME i3status-rust hypr-t480

delete-x240:
	stow --no-folding -v -t $$HOME --delete i3-x240
	stow --no-folding -v -t $$HOME --delete i3status-rust

install-biltower:
	stow --no-folding --restow -v -t $$HOME i3-biltower sway-biltower hypr-biltower

delete-biltower:
	stow --no-folding -v -t $$HOME --delete i3-biltower sway-biltower hypr-biltower

install-EIS-machine:
	stow --no-folding --restow -v -t $$HOME i3-eistower

delete-EIS-machine:
	stow --no-folding -v -t $$HOME --delete i3-eistower
