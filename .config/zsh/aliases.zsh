# cat
alias cat="bat"

alias bathelp="bat --plain --language=help"

help() {
    "$@" --help 2>&1 | bathelp
}

# cp
alias cp="cp -vr"

# df - disk usage
alias df="df -h"     # human-readable sizes

# free - memory usage
alias free="free -m" # show sizes in MB

# fonts
alias fonts="fc-cache -f -v"

# git
alias dot="git --git-dir=$DOTFILESDIR --work-tree=$HOME"
alias gitc="git clone"
alias gitl="git log --oneline --graph"
alias gita="git add"

# ls
alias ls="eza --icons --group-directories-first"
alias la="eza --icons --all --group-directories-first"
alias ll="eza --icons --long --header --group-directories-first"
alias l.="eza -a | egrep "^\.""
alias lla="eza --icons --long --header --all --group-directories-first"

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# mv
alias mv="mv -v"

# mkdir
alias mkdir="mkdir -p"

# neovim
alias vim="nvim"
alias svim="sudoedit"
alias nvimrc="nvim ~/.config/nvim/"
alias dvim="vim -u /usr/share/nvim/archlinux.vim"	 # Load nvim with default config

# pacman
alias cleanup="sudo pacman -Rns $(pacman -Qtdq)"

# rm
alias rm="rm -rv"

# system
alias shutdown="sudo shutdown now"
alias restart="sudo reboot"
alias suspend="sudo pm-suspend"

# tree
alias tree="exa --tree --level=2"
