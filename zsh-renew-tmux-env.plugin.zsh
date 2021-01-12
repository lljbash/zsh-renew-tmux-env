# Renew environment variables in tmux

if [ -n "$TMUX" ]; then
    function renew_tmux_env {
        export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
        export $(tmux show-environment | grep "^DISPLAY")
    }
else
    function renew_tmux_env {}
fi

function preexec {
    renew_tmux_env
}

zle -N renew_tmux_env
# ctrl-alt-T
bindkey -M emacs '^[^T' sudo-command-line
bindkey -M vicmd '^[^T' sudo-command-line
bindkey -M viins '^[^T' sudo-command-line
