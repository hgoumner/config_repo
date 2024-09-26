# Setup fzf
# ---------
if [[ ! "$PATH" == */home/$(whoami)/.fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/home/$(whoami)/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/$(whoami)/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/$(whoami)/.fzf/shell/key-bindings.zsh"

# export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude BraveSoftware --exclude .git'

export FZF_CTRL_T_COMMAND='fd --type f --hidden --follow --exclude BraveSoftware --exclude .git'
export FZF_CTRL_T_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'

export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude BraveSoftware --exclude .git'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

export FZF_DEFAULT_OPTS='
    --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
    --color info:150,prompt:110,spinner:150,pointer:167,marker:174
'

