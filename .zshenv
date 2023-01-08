#SHELL
export TERM="xterm-256color"

# XDG
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

# ZSH
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}
export KEYTIMEOUT=5
export DOTFILESDIR=${DOTFILESDIR:-$HOME/.dotfiles}
export ALIASDIR=${ALIASDIR:-$XDG_CONFIG_HOME/aliases}
export STARSHIP_CONFIG=${STARSHIP_CONFIG:-$XDG_CONFIG_HOME/starship/starship.toml}

# EDITORS
export EDITOR="nvim"
export VISUAL="nvim"

# MANPAGER
# export PAGER="sh -c 'col -bx | bat -l man -p'"
