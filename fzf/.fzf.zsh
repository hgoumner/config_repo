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

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude BraveSoftware --exclude .git'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'

export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude BraveSoftware --exclude .git'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

export FZF_DEFAULT_OPTS='
  --color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
  --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
'

