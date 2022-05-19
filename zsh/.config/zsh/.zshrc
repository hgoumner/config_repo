# -----------------------
# -------- Theme --------
# -----------------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme" ]] || source "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme"

# if [[ ! -e ~/powerlevel10k ]]; then
#   git -C ~ clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git
# fi
#
# source ~/.config/zsh/.p10k.zsh
# return

# ------------------------------
# -------- ZSH settings --------
# ------------------------------

# set zsh directory and history options
# export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history
setopt appendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
# stty stop undef       # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP

# Colors
autoload -Uz colors && colors

# --------------------------------
# -------- External files --------
# --------------------------------

# Useful Functions
source "$ZDOTDIR/zsh-functions"
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-completions"
zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-aliases"

# Plugins
zsh_add_plugin "romkatv/powerlevel10k"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-completions"
zsh_add_plugin "hlissner/zsh-autopair"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------------------------------
# -------- Key-bindings --------
# ------------------------------

# Key-bindings
bindkey '\e[1;5C' forward-word
bindkey '\e[1;5D' backward-word
bindkey -s '^h' ' --help'

# ------------------------------
# ------------ Conda -----------
# ------------------------------

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

# -----------------------
# -------- Theme --------
# -----------------------

# # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

