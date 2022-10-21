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

rga-fzf-all() {
    local match=$(
      rga --hidden --column --no-heading --color=always --smart-case "${*:-}" |
        fzf --ansi --delimiter : --nth 3.. \
            --preview "[[ ! -z {} ]] && rga --pretty --line-number --context 5 {q} {1}"
      )
    local file=$(echo "$match" | cut -d':' -f1)
    if [[ -n $file ]]; then
        $EDITOR "$file" +$(echo "$match" | cut -d':' -f2)
    fi
}

# rga-fzf-all() {
# 	RG_PREFIX="rga --hidden --files-with-matches --column --line-number --no-heading --color=always"
# 	local file
# 	file="$(
# 		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
# 			fzf --ansi --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
# 				--phony -q "$1" \
# 				--bind "change:reload:$RG_PREFIX {q}"
# 	)" &&
# 	echo "opening $file" &&
# 	xdg-open "$file"
# }
#
# rg-fzf-nvim(){
#     local match=$(
#       rg --column --line-number --no-heading --color=always --smart-case "${*:-}" |
#         fzf --ansi --delimiter : \
#             --preview "nvim +{2} {1}"
#       )
#     local file=$(echo "$match" | cut -d':' -f1)
#     if [[ -n $file ]]; then
#         $EDITOR "$file" +$(echo "$match" | cut -d':' -f2)
#     fi
# }
#
# rg-fzf-bat(){
#     local match=$(
#       rg --column --line-number --no-heading --color=always --smart-case "${*:-}" |
#         fzf --ansi --delimiter : \
#             --preview "bat --style=numbers --color=always --highlight-line {2} {1}"
#       )
#     local file=$(echo "$match" | cut -d':' -f1)
#     if [[ -n $file ]]; then
#         $EDITOR "$file" +$(echo "$match" | cut -d':' -f2)
#     fi
# }
#

zle     -N  rga-fzf-all
bindkey '^H' rga-fzf-all

# zle     -N  rg-fzf-bat
# bindkey '^P' rg-fzf-bat
#
#
# zle     -N  rg-fzf-nvim
# bindkey '^H' rg-fzf-nvim
