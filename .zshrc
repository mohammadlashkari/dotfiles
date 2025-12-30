# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Load completions
autoload -Uz +X compinit && compinit
autoload -Uz +X bashcompinit && bashcompinit
autoload -Uz edit-command-line
autoload -Uz zmv

# Keybindings
bindkey -v 
bindkey '^?' backward-delete-char
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
zle -N edit-command-line
bindkey '^x^e' edit-command-line
bindkey -s '^f' 'command -v tmux-sessionizer >/dev/null && tmux-sessionizer\n'

# History
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt glob_dots

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Aliases
alias ls='ls --color'
alias grep='grep --color'
alias vim='nvim'
alias k='kubectl'

# ENV
export EDITOR=/usr/bin/nvim
export MANPAGER='nvim +Man!'
export KEYTIMEOUT=1
export GOPATH=$HOME/go
PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$GOPATH/bin
PATH=$PATH:/usr/local/go/bin

# FZF
export FZF_DEFAULT_OPTS='--reverse'
source <(fzf --zsh)

# STARSHIP
eval "$(starship init zsh)"
