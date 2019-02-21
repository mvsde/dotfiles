export ZSH="/Users/fynn/.oh-my-zsh"

ZSH_THEME=""

plugins=(
  docker
  docker-compose
  osx
  watson
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='nano'

autoload -U promptinit; promptinit
prompt pure
