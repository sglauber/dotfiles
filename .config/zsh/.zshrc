# Load zap plugin manager
[ -f "$XDG_DATA_HOME/zap/zap.zsh" ] && source "$XDG_DATA_HOME/zap/zap.zsh"

# Kitty fix for ssh
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# Autoload functions
autoload -Uz edit-command-line		# Autoload vim edit command function
autoload -U compinit; compinit

# Plugins
plug "greymd/docker-zsh-completion"
plug "zap-zsh/zap-prompt"
plug "hlissner/zsh-autopair"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "Aloxaf/fzf-tab"

# Sourcing
. "$ALIASFILE"
. "$ZDOTDIR/set.zsh"
. "$ZDOTDIR/exports.zsh"
. "$ZDOTDIR/keybindings.zsh"
. "/opt/asdf-vm/asdf.sh"

for file in $ZDOTDIR/functions/*; do
    if [[ -f "$file" ]]; then
        source "$file"
    fi
done
