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

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=nano

alias dc=docker-compose

autoload -U promptinit; promptinit
prompt pure

function cd () {
  builtin cd "$@" && ls -lAh
}
