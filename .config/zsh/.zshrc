# Autoload functions
autoload -Uz colors && colors		# Enable colors, ls, dirs...
autoload -Uz edit-command-line		# Autoload vim edit command function

# History settings
HISTFILE="$XDG_CACHE_HOME/.zsh_history"
HISTFILESIZE=10000			# Maximum size of history file
HISTSIZE=10000				# Maximum size of history (kept in memory)
SAVEHIST=$HISTSIZE

# Enable Vi mode
bindkey -v
bindkey -M vicmd v edit-command-line	# Bind v key to open command in vim
zle -N edit-command-line		# Binding the new keymap do zshzle

# Source
. $ALIASDIR				# Aliaes
. $ZDOTDIR/completions.zsh

if [ -d $ZDOTDIR/plugins ] ; then
  for f in $ZDOTDIR/plugins/*/*?.*plugin*.zsh ; do
    [ -f "$f" ] && . "$f"
  done
  unset f
fi

# Set options
setopt autocd				# No need to type 'cd' to change dirs
setopt extendedhistory
setopt hist_save_no_dups
setopt hist_ignore_all_dups
setopt inc_append_history_time  	# Save command to history after execution
unsetopt share_history          	# Share command history data throught shell sessions
unsetopt inc_append_history     	# Add commands to HISTFILE on exit

# Enable starship prompt
eval "$(starship init zsh)"
