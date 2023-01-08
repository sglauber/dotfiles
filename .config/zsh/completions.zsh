# Should be called before compinit
zmodload zsh/complist
autoload -U compinit
_comp_options+=(globdots) # With hidden files

# Options

# setopt GLOB_COMPLETE		# Show autocompletion menu with globs
setopt AUTO_LIST            	# Automatically list choices on ambiguous completion.
setopt MENU_COMPLETE        	# Automatically highlight first element of completion menu
setopt COMPLETE_IN_WORD     	# Complete from both ends of a word.

# Enables menu selection
zstyle ':completion:*' menu select

compinit
