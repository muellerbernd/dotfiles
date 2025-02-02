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

# terminal settings
export TERM='xterm-256color'

# use starship as prompt
eval "$(starship init bash)"

# use zoxide
eval "$(zoxide init bash)"

# direnv
eval "$(direnv hook bash)"

# atuin
eval "$(atuin init bash --disable-up-arrow)"
