# Enable colors
autoload -U colors && colors

# History settings
HISTFILE="$XDG_CACHE_HOME/.zsh_history"
HISTFILESIZE=10000 						# Set maximum size of history file
HISTSIZE=10000							# Maximum size of history (kept in memory)
SAVEHIST=$HISTSIZE

# Source
source $ALIASDIR
source $ZDOTDIR/completions.zsh

if [ -d $ZDOTDIR/plugins ] ; then
  for f in $ZDOTDIR/plugins/*/*?.zsh ; do
    [ -f "$f" ] && . "$f"
  done
  unset f
fi

# Set options
setopt extendedhistory
setopt hist_ignore_all_dups
setopt autocd

# Vi mod
bindkey -v				# Enable vi mode
export KEYTIMEOUT=1			# Reduce keytimeout await time
zle -N edit-command-line		# Enable command editor on vim
autoload -Uz edit-command-line		# Load function
bindkey -M vicmd v edit-command-line	# Bind v key to open vim

# Keybinding
bindkey '^[[Z' reverse-menu-complete				# Bind <Shift + Tab> to reverse-menu-selection

# spelling corrections for all arguments (also commands)
setopt correctall

eval "$(starship init zsh)"
