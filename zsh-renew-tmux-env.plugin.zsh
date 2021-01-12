# Renew environment variables in tmux

if [ -n "$TMUX" ]; then
    function renew_tmux_env_one {
        oneenv=$(tmux show-environment | grep "^$1")
        [[ ! -z $oneenv ]] && export $oneenv
    }
    function renew_tmux_env {
        renew_tmux_env_one DISPLAY
        renew_tmux_env_one SSH_CONNECTION
        renew_tmux_env_one SSH_AUTH_SOCK
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
