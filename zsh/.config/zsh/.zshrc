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

# Normal files to source
zsh_add_file ".zsh_completions"
zsh_add_file ".zsh_vim-mode"
zsh_add_file ".zsh_aliases"
zsh_add_file ".zsh_keymaps"
zsh_add_file ".zsh_options"

# PharVision
zsh_add_file "pharvision"

[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
[ -f "$HOME/.config/local/share/zap/zap.zsh" ] && source "$HOME/.config/local/share/zap/zap.zsh"

# Plugins
plug "zap-zsh/supercharge"
plug "romkatv/powerlevel10k"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-completions"
plug "hlissner/zsh-autopair"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
HISTSIZE=10000                   # Maximum events for internal history
SAVEHIST=10000                   # Maximum events in history file

# -----------------------
# -------- Theme --------
# -----------------------

# # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
