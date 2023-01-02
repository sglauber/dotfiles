# Environment variables

# XDG
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

# ZSH
export STARSHIP_CONFIG=${STARSHIP_CONFIG:-$XDG_CONFIG_HOME/starship/starship.toml}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}
export ALIASDIR=${ALIASDIR:-$ZDOTDIR/.aliases}
export DOTFILESDIR=${DOTFILESDIR:-$HOME/.dotfiles}

# Set editors
export PAGER="less"
#export VISUAL="code"
export EDITOR="nvim"
