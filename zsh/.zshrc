# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="false"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
# zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash
# fpath=(/usr/local/share/zsh-completions $fpath)
# autoload -U compinit && compinit
# zmodload -i zsh/complist
# zstyle ':completion:*' menu select
autoload -U bashcompinit
bashcompinit

# antigen setup
if [ -f /usr/share/zsh/share/antigen.zsh ]; then
    source /usr/share/zsh/share/antigen.zsh
elif [ -f ~/antigen.zsh ]; then
    source ~/antigen.zsh
else
    curl -L git.io/antigen >~/antigen.zsh
    source ~/antigen.zsh
    print "Installed Antigen from main repository with the latest stable version available!"
fi

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundles <<EOBUNDLES
#command-not-found
#colored-man-pages
#magic-enter
#extract
# tmux
# tmuxinator
git
zsh-users/zsh-completions
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
EOBUNDLES

# Tell Antigen that you're done.
antigen apply

# use starship as prompt
eval "$(starship init zsh)"

# export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
# export PATH=$HOME/bin:/usr/local/bin:/sbin:/usr/sbin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$HOME/.cargo/bin:$PATH
export PATH=$PATH:$HOME/.nix-profile/bin:$PATH

# You can use fd to generate input for the command-line fuzzy finder fzf:
# export FZF_DEFAULT_COMMAND="fd --type file --color=always --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_COMMAND="fd --color=always --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# enable control-s and control-q
stty start undef
stty stop undef
setopt noflowcontrol

bindkey '\e[1~' beginning-of-line # Linux console
bindkey '\e[H' beginning-of-line  # xterm
bindkey '\eOH' beginning-of-line  # gnome-terminal
bindkey '\e[2~' overwrite-mode    # Linux console, xterm, gnome-terminal
bindkey '\e[3~' delete-char       # Linux console, xterm, gnome-terminal
bindkey '\e[4~' end-of-line       # Linux console
bindkey '\e[F' end-of-line        # xterm
bindkey '\eOF' end-of-line        # gnome-terminal

# Window names are not displaying properly in tmux
export DISABLE_AUTO_TITLE=true

# default editor
export EDITOR='nvim'
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# hide Executing command "..." timed out.
# https://starship.rs/faq/#why-do-i-see-executing-command-timed-out-warnings
export STARSHIP_LOG='error'

# RPROMPT='[%D{%L:%M:%S}] '$RPROMPT
# RPROMPT='[%D{%L:%M:%S %p}]'
# taken from here: https://stackoverflow.com/questions/2187829/constantly-updated-clock-in-zsh-prompt
# RPROMPT='[%D{%H:%M:%S %p}]'
# schedprompt() {
#   emulate -L zsh
#   zmodload -i zsh/sched
#
#   # Remove existing event, so that multiple calls to
#   # "schedprompt" work OK.  (You could put one in precmd to push
#   # the timer 30 seconds into the future, for example.)
#   integer i=${"${(@)zsh_scheduled_events#*:*:}"[(I)schedprompt]}
#   (( i )) && sched -$i
#
#   # Test that zle is running before calling the widget (recommended
#   # to avoid error messages).
#   # Otherwise it updates on entry to zle, so there's no loss.
#   zle && zle reset-prompt
#
#   # This ensures we're not too far off the start of the minute
#   sched +30 schedprompt
# }
#
# schedprompt

# load aliases
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
else
    print "404: ~/.zsh_aliases not found."
fi

if [ -f ~/.zsh_aliases_work ]; then
    source ~/.zsh_aliases_work
else
    # print "404: ~/.zsh_aliases_work not found."
fi

# setup nix
if [ -f /usr/share/zsh/plugins/zsh-nix-shell/nix-shell.plugin.zsh ]; then
    source /usr/share/zsh/plugins/zsh-nix-shell/nix-shell.plugin.zsh
else
fi

# vcs setup autocompletion
if [ -f /usr/share/vcstool-completion/vcs.zsh ]; then
    source /usr/share/vcstool-completion/vcs.zsh
fi

ros2_on() {
    # export ROS_DOMAIN_ID=42
    # export ROS_VERSION=2
    # export ROS_PYTHON_VERSION=3
    # export ROS_DISTRO=git
    source /opt/ros2/humble/setup.zsh
    # argcomplete for ros2 & colcon
    # https://github.com/ros2/ros2cli/issues/534
    eval "$(register-python-argcomplete ros2)"
    eval "$(register-python-argcomplete colcon)"
}

ros1_on() {
    rosexport
    source /opt/ros/noetic/setup.zsh
}

# custom funcs
gitaur() {echo $1 | awk '{print "git clone https://aur.archlinux.org/"$1".git"}' | xargs -I % sh -c %}

safedelete() {
    if command -v gio >/dev/null; then
        for f in "$@"; do
            gio trash -f "$f"
        done

    elif command -v gvfs-trash >/dev/null; then
        for f in "$@"; do
            gvfs-trash "$f"
        done

    elif [ -d "$HOME/.local/share/Trash/files" ]; then
        for f in "$@"; do
            mv "$f" "$HOME/.local/share/Trash/files"
        done

    else
        for f in "$@"; do
            # shellcheck disable=SC1012
            \rm "$f"
        done
    fi
}

# nvidia_offload() {
#     export __NV_PRIME_RENDER_OFFLOAD=1
#     export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
#     export __GLX_VENDOR_LIBRARY_NAME=nvidia
#     export __VK_LAYER_NV_optimus=NVIDIA_only
#     exec "$@"
# }

rr() {
    temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
    ranger --choosedir="$temp_file" -- "${@:-$PWD}"
    if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
        cd -- "$chosen_dir"
    fi
    rm -f -- "$temp_file"
}

jj() {
    temp_file="$(mktemp -t "joshuto_cd.XXXXXXXXXX")"
    # ~/.config/joshuto/uberzug/joshuto.sh --output-file "$temp_file" -- "${@:-$PWD}"
    joshuto --output-file "$temp_file" -- "${@:-$PWD}"
    if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
        cd -- "$chosen_dir"
    fi
    rm -f -- "$temp_file"
}

ya() {
    temp_file="$(mktemp -t "yazi_cd.XXXXXXXXXX")"
    yazi --cwd-file "$temp_file" -- "${@:-$PWD}"
    if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
        cd -- "$chosen_dir"
    fi
    rm -f -- "$temp_file"
}

# terminal settings
export TERM='tmux-256color'
# [[ -n $TMUX ]] && export TERM="tmux-256color"

# WINDOW TITLE
# https://wiki.gentoo.org/wiki/Alacritty#Zsh
if [[ "${TERM}" != "" && "${TERM}" == "alacritty" || "${TERM}" != "" && "${TERM}" == "xterm-256color" || "${TERM}" != "" && "${TERM}" == "tmux-256color" ]]; then
    precmd() {
        # output on which level (%L) this shell is running on.
        # append the current directory (%~), substitute home directories with a tilde.
        # "\a" bell (man 1 echo)
        # "print" must be used here; echo cannot handle prompt expansions (%L)
        print -Pn "\e]0;$(id --user --name)@$HOST: zsh[%L] %~\a"
    }

    preexec() {
        # output current executed command with parameters
        echo -en "\e]0;$(id --user --name)@$HOST: ${1}\a"
    }
fi

# use zoxide
eval "$(zoxide init zsh)"

# direnv
eval "$(direnv hook zsh)"

# atuin
eval "$(atuin init zsh --disable-up-arrow)"

export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
