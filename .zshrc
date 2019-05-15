fpath=( "$HOME/.zfunctions" $fpath )

export ZSH="/home/fynn/.oh-my-zsh"

ZSH_THEME=""

plugins=(
  docker
  docker-compose
  npm
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

autoload -U promptinit; promptinit
prompt pure


# Environment variables

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nano


# Aliases

alias dc=docker-compose


# Functions

function cd () {
  builtin cd "$@"
  echo ""
  ls -lAh
}
