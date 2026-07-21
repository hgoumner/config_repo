#!/usr/bin/env zsh

# -----------------------------------------------------------------
# DOTFILES
# -----------------------------------------------------------------

[ -f "$HOME/.dotfiles" ] && export DOTFILES="$HOME/.dotfiles"

# -----------------------------------------------------------------
# XDG VARIABLES
# -----------------------------------------------------------------

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# -----------------------------------------------------------------
# EDITOR
# -----------------------------------------------------------------

export EDITOR="nvim"
export VISUAL="$EDITOR"

# -----------------------------------------------------------------
# RUST
# -----------------------------------------------------------------

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -d "$HOME/.cargo/bin/" ] && export PATH="$HOME/.cargo/bin:$PATH"

# -----------------------------------------------------------------
# PYTHON
# -----------------------------------------------------------------

# -----------------------------------------------------------------
# FZF
# -----------------------------------------------------------------

[ -d "$HOME/.fzf/bin" ] && export PATH=$PATH:~/.fzf/bin/
export FZF_TMUX_HEIGHT='100%'

[ -f "$HOME/.fzf/shell/key-bindings.zsh" ] && source "/home/$(whoami)/.fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude Brave --exclude .git'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'

export FZF_ALT_C_COMMAND='fd --type d --hidden --follow'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"


export PATH="$HOME/.local/bin":$PATH
export MANWIDTH=999

# -----------------------------------------------------------------
# Docker
# -----------------------------------------------------------------

export DOCKER_CONTENT_TRUST=0

# ----------------------------------
# -------- AI Settings --------
# ----------------------------------

# ----------------------------------
# -------- Export variables --------
# ----------------------------------

# flatpak apps
[ -d "/var/lib/flatpak/exports/bin/" ] && export PATH=$PATH:'/var/lib/flatpak/exports/bin/'

# cli apps
export PATH=$PATH:'/home/hristo/Apps/'

# bookmarks
[ -d "$HOME/.bookmarks" ] && export CDPATH=.:~/.bookmarks

# bat theme
export BAT_THEME=gruvbox-dark

# keytimeout
export KEYTIMEOUT=50

# npm and node
[ -d "$HOME/.config/nvm" ] && export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# FORGIT
export FORGIT_FZF_DEFAULT_OPTS="
--exact
--border
--cycle
--height '100%'
"

export FORGIT_COPY_CMD='xclip -selection clipboard'

export ATUIN_NOBIND="true"

export STORE_DIRECTORY="/xps-other/AlphaScienceData/Finance/Binance/"

# -----------------------------------------------------------------
# ZSH
# -----------------------------------------------------------------

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file
export HISTDUP=erase

export LS_COLORS="$(vivid generate molokai)"
