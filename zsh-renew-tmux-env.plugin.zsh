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
bindkey -M emacs '^[^T' renew_tmux_env
bindkey -M vicmd '^[^T' renew_tmux_env
bindkey -M viins '^[^T' renew_tmux_env
