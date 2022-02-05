# Setup fzf
# ---------
if [[ ! "$PATH" == */home/user/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/user/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/user/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/user/.fzf/shell/key-bindings.zsh"

export FZF_CTRL_T_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'
