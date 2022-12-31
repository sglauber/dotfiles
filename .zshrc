# ENVVARS Exports
export ZSH="$HOME/.oh-my-zsh"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Updates
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 15

# Shell
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins
plugins=(
	git
	yarn
	asdf
	docker
	zsh-autosuggestions
	fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User settings
export LANG=en_US.UTF-8

# Editor config for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Aliases
alias config="/usr/bin/git --git-dir='$HOME'/.dotfiles/ --work-tree=$HOME"

# Themes
# ZSH_THEME="robbyrussell"
eval "$(starship init zsh)"
