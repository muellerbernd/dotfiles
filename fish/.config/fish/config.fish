if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting # Disable greeting
starship init fish | source
atuin init fish --disable-up-arrow | source
zoxide init fish | source
direnv hook fish | source

# functions

function ya
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# aliases
alias tm="tmux a || tmux"
alias l="eza -l --git -O"

# set env vars
export FZF_DEFAULT_COMMAND="fd --color=always --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Window names are not displaying properly in tmux
export DISABLE_AUTO_TITLE=true

# default editor
export EDITOR='nvim'
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# hide Executing command "..." timed out.
# https://starship.rs/faq/#why-do-i-see-executing-command-timed-out-warnings
export STARSHIP_LOG='error'
