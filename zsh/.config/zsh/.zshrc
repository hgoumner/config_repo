#!/usr/bin/env zsh

# -----------------------
# -------- Theme --------
# -----------------------

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

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/fzf-git.sh/fzf-git.sh ] && source ~/fzf-git.sh/fzf-git.sh

# Broot
[ -f ~/.config/broot/launcher/bash/br ] && source ~/.config/broot/launcher/bash/br

# atuin
[ -f "$HOME/.atuin/bin/env" ] && source "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# uv
source "$HOME/.config/local/share/../bin/env"

# Normal files to source
zsh_add_file ".zsh_completions"

# ZSH files
zsh_add_file ".zsh_vim-mode"
zsh_add_file ".zsh_aliases"
zsh_add_file ".zsh_keymaps"
zsh_add_file ".zsh_options"

### Added by Zinit's installer
if [[ ! -f $HOME/.config/local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.config/local/share/zinit" && command chmod g-rwX "$HOME/.config/local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.config/local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.config/local/share/zinit/zinit.git/zinit.zsh"
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

# zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light hlissner/zsh-autopair
zinit light Aloxaf/fzf-tab
zinit light wfxr/forgit
zinit light atuinsh/atuin
zinit light ocodo/ollama_zsh_completion

### End of Zinit's installer chunk

# -----------------------
# -------- Theme --------
# -----------------------

eval "$(starship init zsh)"

tput cup $LINES 0
