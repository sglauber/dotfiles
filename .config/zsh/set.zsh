#!/bin/sh

# Set options
setopt autocd				# No need to type 'cd' to change dirs
setopt extendedhistory
setopt hist_save_no_dups
setopt hist_ignore_all_dups
setopt inc_append_history_time  	# Save command to history after execution
unsetopt share_history          	# Share command history data throught shell sessions
unsetopt inc_append_history     	# Add commands to HISTFILE on exit
