# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export HOMEBREW_NO_INSTALL_CLEANUP=1

# Oh my zsh
export ZSH="$HOME/.oh-my-zsh"

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

DISABLE_AUTO_TITLE="true"
precmd() { print -Pn "\033]0;${PWD##*/}\007" }

source $ZSH/oh-my-zsh.sh

# Oh my posh theme
eval "$(oh-my-posh init zsh --config ~/.dotfiles/oh-my-posh/hul10-custom.json)"

# Carapace
function lsp() {
  export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
  zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
  source <(carapace _carapace)
}

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


export VISUAL='nvim'
export EDITOR="$VISUAL"

export PATH=$PATH:$HOME/go/bin
