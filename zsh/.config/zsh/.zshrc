#!/usr/bin/env zsh

# -----------------------
# -------- Theme --------
# -----------------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# [[ ! -f "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme" ]] || source "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme"

# --------------------------------
# -------- External files --------
# --------------------------------

# Useful Functions
source "$ZDOTDIR/.zsh_functions"
fpath+=${ZDOTDIR:-~}/.zsh_functions

[ -f "$HOME/.zshenv" ] && source "$HOME/.zshenv"

# PharVision
zsh_add_file "pharvision"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
HISTSIZE=10000                   # Maximum events for internal history
SAVEHIST=10000                   # Maximum events in history file

# Normal files to source
zsh_add_file ".zsh_completions"

# ZSH files
zsh_add_file ".zsh_vim-mode"
zsh_add_file ".zsh_aliases"
zsh_add_file ".zsh_keymaps"
zsh_add_file ".zsh_options"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/fzf-git.sh/fzf-git.sh ] && source ~/fzf-git.sh/fzf-git.sh

# Broot
[ -f ~/.config/broot/launcher/bash/br ] && source ~/.config/broot/launcher/bash/br

# -----------------------
# -------- Theme --------
# -----------------------

# # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/hristo/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/hristo/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/hristo/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/hristo/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/hristo/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/hristo/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

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
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

tput cup $LINES 0

