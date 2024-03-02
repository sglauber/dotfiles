# SHELL
export TERM="xterm-256color"

# Adds directories to $PATH
export PATH="$HOME/.local/bin"

# XDG
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

# ZSH
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}
export DOTFILESDIR=${DOTFILESDIR:-$HOME/dotfiles}
export ALIASFILE=${ALIASDIR:-$ZDOTDIR/aliases.zsh}

# EDITORS
export EDITOR="nvim"
export VISUAL="nvim"

# APPLICATIONS DATA
export ASDF_DIR=/opt/asdf-vm/
export ASDF_DATA_DIR=${ASDF_DATA_DIR:-$XDG_DATA_HOME/asdf}
export ASDF_CONFIG_FILE=${ASDF_DATA_DIR/.asdfrc}
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"

# MANPAGER
export MANROFFOPT="-c"

# VIM AS MANPAGER
export MANPAGER='nvim +Man! +"set nocul" +"set noshowcmd" +"set noruler" +"set noshowmode" +"set laststatus=0" +"set showtabline=0" +"set nonumber"'

if [ $(echo $MANPAGER | awk '{print $1}') = nvim ]; then
  export LESS="--RAW-CONTROL-CHARS"
  export MANPAGER="less -s -M +Gg"

  export LESS_TERMCAP_mb=$'\e[1;32m'
  export LESS_TERMCAP_md=$'\e[1;32m'
  export LESS_TERMCAP_me=$'\e[0m'
  export LESS_TERMCAP_se=$'\e[0m'
  export LESS_TERMCAP_so=$'\e[01;33m'
  export LESS_TERMCAP_ue=$'\e[0m'
  export LESS_TERMCAP_us=$'\e[1;4;31m'
fi

export LC_ALL=en_US.UTF-8

# FZF
export FZF_DEFAULT_COMMAND='fd -H'

# export FZF_DEFAULT_OPTS="
#   --color fg:#cdd6f4
#   --color fg+:#cdd6f4
#   --color bg+:#313244
#   --color hl:#f38ba8
#   --color hl+:#f38ba8
#   --color info:#cba6f7
#   --color prompt:#cba6f7
#   --color spinner:#f5e0dc
#   --color pointer:#f5e0dc
#   --color marker:#f5e0dc
#   --color border:#1e1e2e
#   --color header:#f38ba8
#   --layout=reverse
#   --border horizontal
#   --height 40"

# vim:ft=zsh
