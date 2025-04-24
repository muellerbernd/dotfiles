# # zplug setup
# if [ -f $HOME/.zplug/init.zsh ]; then
# else
#     git clone https://github.com/zplug/zplug "${HOME}/.zplug"
#     echo "Installed zplug from main repository with the latest stable version available!"
# fi
#
# source ~/.zplug/init.zsh
#
# zplug "zsh-users/zsh-completions"
# zplug "zsh-users/zsh-autosuggestions"
# zplug "zsh-users/zsh-syntax-highlighting"
# zplug "zsh-users/zsh-history-substring-search"
# # Supports oh-my-zsh plugins and the like
# # zplug "BronzeDeer/zsh-completion-sync", \
# #     at:v0.3.0, \
# #     defer:3
# # zplug "BronzeDeer/zsh-completion-sync"
# # zplug 'zplug/zplug', hook-build:'zplug --self-manage'
#
# # Install plugins if there are plugins that have not been installed
# if ! zplug check --verbose; then
#     printf "Install? [y/N]: "
#     if read -q; then
#         echo; zplug install
#     fi
# fi
# zplug load
# ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
# [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
# source "${ZINIT_HOME}/zinit.zsh"
# # Two regular plugins loaded without investigating.
# zinit light zsh-users/zsh-autosuggestions
# zinit light zsh-users/zsh-syntax-highlighting
# zinit light zsh-users/zsh-history-substring-search
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
    zsh-users/zsh-completions
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-history-substring-search
EOBUNDLES

# Tell Antigen that you're done.
antigen apply

# zstyle ':completion:*' menu select

# loads the zsh completion initialization module, only
# do this once, if you are already loading completions you don't need to add this again
# autoload -U compinit && compinit

# You can use fd to generate input for the command-line fuzzy finder fzf:
# export FZF_DEFAULT_COMMAND="fd --type file --color=always --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_COMMAND="fd --color=always --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Window names are not displaying properly in tmux
export DISABLE_AUTO_TITLE=true

# default editor
export EDITOR='nvim'
# export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# hide Executing command "..." timed out.
# https://starship.rs/faq/#why-do-i-see-executing-command-timed-out-warnings
export STARSHIP_LOG='error'

# load aliases
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
else
    print "404: ~/.zsh_aliases not found."
fi

# if [ -f ~/.zsh_aliases_work ]; then
#     source ~/.zsh_aliases_work
# else
#     # print "404: ~/.zsh_aliases_work not found."
# fi


# terminal settings
export TERM='xterm-256color'
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

# eval "$(just --completions zsh)"

# keybinds
# bindkey '\e[1~' beginning-of-line # Linux console
# bindkey '\e[H' beginning-of-line  # xterm
# bindkey '\eOH' beginning-of-line  # gnome-terminal
# bindkey '\e[2~' overwrite-mode    # Linux console, xterm, gnome-terminal
# bindkey '\e[3~' delete-char       # Linux console, xterm, gnome-terminal
# bindkey '\e[4~' end-of-line       # Linux console
# bindkey '\e[F' end-of-line        # xterm
# bindkey '\eOF' end-of-line        # gnome-terminal

# bindkey "^[[A" history-substring-search-up
# bindkey "^[[B" history-substring-search-down

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt inc_append_history

ZSH_HIGHLIGHT_STYLES[comment]=fg=245

export MANPAGER="nvim +Man!"
