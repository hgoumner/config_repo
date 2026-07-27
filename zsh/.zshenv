#!/usr/bin/env zsh

# -----------------------------------------------------------------
# FZF
# -----------------------------------------------------------------

export FZF_TMUX_HEIGHT='100%'

export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude Brave --exclude .git'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'

export FZF_ALT_C_COMMAND='fd --type d --hidden --follow'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# FORGIT
export FORGIT_FZF_DEFAULT_OPTS="
--exact
--border
--cycle
--height '100%'
"

# -----------------------------------------------------------------
# ZSH
# -----------------------------------------------------------------

export ZDOTDIR="$HOME/.config/zsh"

export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file
export HISTDUP=erase

export LS_COLORS="$(vivid generate molokai)"

# ----------------------------------
# -------- Export variables --------
# ----------------------------------

export EDITOR="nvim"
export VISUAL="$EDITOR"

export PATH="$HOME/.local/bin":$PATH
export MANWIDTH=999

export ATUIN_NOBIND="true"
