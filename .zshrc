fpath=( "$HOME/.zfunctions" $fpath )

export ZSH="/home/fynn/.oh-my-zsh"

ZSH_THEME=""

plugins=(
  docker
  docker-compose
  git
  npm
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

autoload -U promptinit; promptinit
prompt pure


# Environment variables

export LANG=en_US.UTF-8
export EDITOR=nano


# Node Version Manager

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


# Aliases

alias dc=docker-compose


# Functions

function cd () {
  builtin cd "$@"
  echo ""
  ls -lAh
}
