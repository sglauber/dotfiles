# History settings
HISTFILE="$ZDOTDIR/.zsh_history"
HISTFILESIZE=5000 # Set maximum size of history file
HISTSIZE=1000 # Maximum size of history (kept in memory)
SAVEHIST=$HISTSIZE

autoload -Uz compinit && compinit
autoload -U colors && colors
autoload -U zmv 

# Source
source $ALIASDIR

if [ -d $ZDOTDIR/plugins ] ; then
  for f in $ZDOTDIR/plugins/*/*?.zsh ; do
    echo "Sourcing: $f"
    [ -f "$f" ] && . "$f"
  done
  unset f
fi

# Set options
setopt extendedhistory
setopt correctall
setopt hist_ignore_all_dups
bindkey -v

# spelling corrections for all arguments (also commands)
setopt correctall

# End of lines added by compinstall
eval "$(starship init zsh)"
