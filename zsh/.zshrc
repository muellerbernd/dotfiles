# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="false"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# loads the zsh completion initialization module, only
# do this once, if you are already loading completions you don't need to add this again
# autoload -U compinit && compinit

# antigen setup
# if [ -f /usr/share/zsh/share/antigen.zsh ]; then
#     source /usr/share/zsh/share/antigen.zsh
# elif [ -f ~/antigen.zsh ]; then
#     source ~/antigen.zsh
# else
#     curl -L git.io/antigen >~/antigen.zsh
#     source ~/antigen.zsh
#     print "Installed Antigen from main repository with the latest stable version available!"
# fi

# Load the oh-my-zsh's library.
# antigen use oh-my-zsh
#
# # Bundles from the default repo (robbyrussell's oh-my-zsh).
# antigen bundles <<EOBUNDLES
# #command-not-found
# #colored-man-pages
# #magic-enter
# #extract
# # tmux
# # tmuxinator
# git
# zsh-users/zsh-completions
# zsh-users/zsh-autosuggestions
# zsh-users/zsh-syntax-highlighting
# BronzeDeer/zsh-completion-sync
# EOBUNDLES

# Tell Antigen that you're done.
# antigen apply

# zgen setup

if [ -f $HOME/.zgen/zgen.zsh ]; then
else
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
    echo "Installed zgen from main repository with the latest stable version available!"
fi

# https://github.com/tarjoilija/zgen
# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    # zgen oh-my-zsh

    # plugins
    # zgen oh-my-zsh plugins/git
    # zgen oh-my-zsh plugins/sudo
    # zgen oh-my-zsh plugins/command-not-found
    # zgen load zsh-users/zsh-syntax-highlighting
    # zgen load /path/to/super-secret-private-plugin
    zgen load zsh-users/zsh-completions
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load BronzeDeer/zsh-completion-sync

    # bulk load
#     zgen loadall <<EOPLUGINS
#         zsh-users/zsh-history-substring-search
#         /path/to/local/plugin
# EOPLUGINS
    # ^ can't indent this EOPLUGINS

    # completions
    # zgen load zsh-users/zsh-completions src

    # theme
    # zgen oh-my-zsh themes/arrow

    # save all to init script
    zgen save
fi


# export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
# export PATH=$HOME/bin:/usr/local/bin:/sbin:/usr/sbin:$PATH
# export PATH=$HOME/.local/bin:$PATH
# export PATH=$PATH:$HOME/.cargo/bin:$PATH
# export PATH=$PATH:$HOME/.nix-profile/bin:$PATH

# You can use fd to generate input for the command-line fuzzy finder fzf:
# export FZF_DEFAULT_COMMAND="fd --type file --color=always --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_COMMAND="fd --color=always --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# source <(fzf --zsh)

# enable control-s and control-q
# stty start undef
# stty stop undef
# setopt noflowcontrol


# Window names are not displaying properly in tmux
export DISABLE_AUTO_TITLE=true

# default editor
export EDITOR='nvim'
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# hide Executing command "..." timed out.
# https://starship.rs/faq/#why-do-i-see-executing-command-timed-out-warnings
export STARSHIP_LOG='error'

ZSH_HIGHLIGHT_STYLES[comment]=fg=245

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


# terminal settings
export TERM='tmux-256color'
# [[ -n $TMUX ]] && export TERM="tmux-256color"

# WINDOW TITLE
# https://wiki.gentoo.org/wiki/Alacritty#Zsh
# if [[ "${TERM}" != "" && "${TERM}" == "alacritty" || "${TERM}" != "" && "${TERM}" == "xterm-256color" || "${TERM}" != "" && "${TERM}" == "tmux-256color" ]]; then
#     precmd() {
#         # output on which level (%L) this shell is running on.
#         # append the current directory (%~), substitute home directories with a tilde.
#         # "\a" bell (man 1 echo)
#         # "print" must be used here; echo cannot handle prompt expansions (%L)
#         print -Pn "\e]0;$(id --user --name)@$HOST: zsh[%L] %~\a"
#     }
#
#     preexec() {
#         # output current executed command with parameters
#         echo -en "\e]0;$(id --user --name)@$HOST: ${1}\a"
#     }
# fi

# use starship as prompt
eval "$(starship init zsh)"

# use zoxide
eval "$(zoxide init zsh)"

# direnv
eval "$(direnv hook zsh)"

# atuin
eval "$(atuin init zsh --disable-up-arrow)"

eval "$(just --completions zsh)"

# keybinds
bindkey '\e[1~' beginning-of-line # Linux console
bindkey '\e[H' beginning-of-line  # xterm
bindkey '\eOH' beginning-of-line  # gnome-terminal
bindkey '\e[2~' overwrite-mode    # Linux console, xterm, gnome-terminal
bindkey '\e[3~' delete-char       # Linux console, xterm, gnome-terminal
bindkey '\e[4~' end-of-line       # Linux console
bindkey '\e[F' end-of-line        # xterm
bindkey '\eOF' end-of-line        # gnome-terminal

HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
