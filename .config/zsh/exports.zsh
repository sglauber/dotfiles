#!/bin/sh

export KEYTIMEOUT=1

# History settings
export HISTFILE="$XDG_CACHE_HOME/.zsh_history"
export HISTFILESIZE=10000			# Maximum size of history file
export HISTSIZE=10000				# Maximum size of history (kept in memory)
export SAVEHIST=$HISTSIZE
