# Setup fzf
# ---------
if [[ ! "$PATH" == */home/gou/.fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/home/$(whoami)/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/$(whoami)/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/$(whoami)/.fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'

export FZF_ALT_C_COMMAND='fd --type d --hidden --follow'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

rg-fzf() {
    INITIAL_QUERY=""
    RG_PREFIX="rg --files-with-matches --hidden --column --line-number --no-heading --color=always --smart-case "
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
        fzf --preview "bat --style=numbers --color=always --line-range :500 {}" --bind "change:reload:$RG_PREFIX {q} || true" \
        --ansi --disabled --query "$INITIAL_QUERY" --layout=reverse
}

zle     -N  rg-fzf
bindkey '^H' rg-fzf
