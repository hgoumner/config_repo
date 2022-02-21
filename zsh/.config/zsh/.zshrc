#!/bin/sh

# -----------------------
# -------- Theme -------- 
# -----------------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------
# -------- ZSH settings -------- 
# ------------------------------

# set zsh directory and history options
export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history
setopt appendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
# stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.

# Colors
autoload -Uz colors && colors

# --------------------------------
# -------- External files -------- 
# --------------------------------

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-aliases"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "romkatv/powerlevel10k"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------------------------------
# -------- Key-bindings -------- 
# ------------------------------

# Key-bindings
bindkey '\e[1;5C' forward-word
bindkey '\e[1;5D' backward-word

# caps remap to escape
setxkbmap -option caps:escape

# -----------------------
# -------- Theme -------- 
# -----------------------

# # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# ----------------------------------
# -------- Export variables -------- 
# ----------------------------------

# ls command color fix
LS_COLORS=$LS_COLORS:'ow=34;33'
export LS_COLORS

# FZF and nodejs
export PATH=$PATH:~/.fzf/bin/
export PATH=$PATH:~/node-v17.3.0-linux-x64/bin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/gou/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/gou/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/gou/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/gou/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
