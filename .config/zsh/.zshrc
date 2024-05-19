# If not in tmux, start tmux.
if [[ -z ${TMUX+X}${ZSH_SCRIPT+X}${ZSH_EXECUTION_STRING+X} ]]; then
  exec tmux
fi

# Enable the completion system
autoload -Uz compinit; compinit
autoload -Uz edit-command-line

# Download zap if missing.
if [[ ! -e ${XDG_DATA_HOME}/zap ]]; then
    git clone --depth 1 \
        https://github.com/zap-zsh/zap "${XDG_DATA_HOME}/zap"
fi

# Activate Powerlevel10k Instant Prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source "$XDG_DATA_HOME/zap/zap.zsh"

function zcompile-many() {
  local f
  for f; do zcompile -R -- "$f".zwc "$f"; done
}

ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Plugins
plug "romkatv/powerlevel10k"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "Aloxaf/fzf-tab"
plug "greymd/docker-zsh-completion"
# I'm stupid and keeping forgetting my aliases
plug "MichaelAquilina/zsh-you-should-use"

# Sourcing
. "$ZDOTDIR/aliases.zsh"
. "$ZDOTDIR/set.zsh"
. "$ZDOTDIR/exports.zsh"
. "$ZDOTDIR/keybindings.zsh"
. "/opt/asdf-vm/asdf.sh"

# for file in $ZDOTDIR/functions/*; do
#     if [[ -f "$file" ]]; then
#         source "$file"
#     fi
# done

[[ ${ZDOTDIR}/.zcompdump.zwc -nt ${ZDOTDIR}/.zcompdump ]] || zcompile-many ${ZDOTDIR}/.zcompdump
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
