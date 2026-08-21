#!/usr/bin/env zsh

# --------------------------------
# -------- External files --------
# --------------------------------

# Useful Functions
source "$ZDOTDIR/.zsh_functions"
fpath+=${ZDOTDIR:-~}/.zsh_functions

[ -f "$HOME/.zshenv" ] && source "$HOME/.zshenv"

HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
HISTSIZE=10000                   # Maximum events for internal history
SAVEHIST=10000                   # Maximum events in history file

# FZF & Skim
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/fzf-git.sh/fzf-git.sh ] && source ~/fzf-git.sh/fzf-git.sh

# Normal files to source
zsh_add_file ".zsh_completions"

# ZSH files
zsh_add_file ".zsh_vim-mode"
zsh_add_file ".zsh_aliases"
zsh_add_file ".zsh_keymaps"
zsh_add_file ".zsh_options"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    zdharma-continuum/fast-syntax-highlighting

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light hlissner/zsh-autopair
zinit light atuinsh/atuin
zinit light Aloxaf/fzf-tab

### End of Zinit's installer chunk

# -----------------------
# -------- Theme --------
# -----------------------

eval "$(starship init zsh)"

tput cup $LINES 0

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/dev/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dev/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/dev/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/dev/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

. "$HOME/.cargo/env"
