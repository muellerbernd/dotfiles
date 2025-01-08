if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting # Disable greeting
starship init fish | source
atuin init fish | source
zoxide init fish | source

# functions

function ya
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Filters an item from an array
# Usage:
#  > fish_completion_filter_from_array bar foo bar baz
#  > foo baz
function fish_completion_sync_filter
    set -l item $argv[1]
    set -e argv[1]
    set -l array $argv
    for array_item in $array
        if [ $array_item != $item ]
            echo $array_item
        end
    end
end

function fish_completion_sync_add_comp
    set -l array $argv
    for array_item in $array
        echo "$array_item/fish/vendor_completions.d"
    end
end

set -g FISH_COMPLETION_ADDITIONS

function fish_completion_sync --on-variable XDG_DATA_DIRS
    set -l FISH_COMPLETION_DATA_DIRS (fish_completion_sync_add_comp (fish_completion_sync_filter "" (string split ":" $XDG_DATA_DIRS)))
    # If there are paths in $FISH_COMPLETION_ADDITIONS,
    # but not in $XDG_DATA_DIRS
    #   remove them from $fish_complete_path
    #   remove them from $FISH_COMPLETION_ADDITIONS
    for addition in $FISH_COMPLETION_ADDITIONS
        # test if addition is in xdg_data_dirs
        if not contains $addition $FISH_COMPLETION_DATA_DIRS
            if set -q FISH_COMPLETION_DEBUG
                echo "removing: $data_dir"
            end
            set fish_complete_path (fish_completion_sync_filter $addition $fish_complete_path)
            set FISH_COMPLETION_ADDITIONS (fish_completion_sync_filter $addition $FISH_COMPLETION_ADDITIONS)
        end
    end

    # if there are paths in $XDG_DATA_DIRS
    # but not in $FISH_COMPLETION_ADDITIONS
    #   add them to $fish_complete_path
    #   add them to $FISH_COMPLETION_ADDITIONS
    for data_dir in $FISH_COMPLETION_DATA_DIRS
        if not contains $data_dir $FISH_COMPLETION_ADDITIONS
            if set -q FISH_COMPLETION_DEBUG
                echo "adding: $data_dir"
            end
            set -a fish_complete_path $data_dir
            set -a FISH_COMPLETION_ADDITIONS $data_dir
        end
    end
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
