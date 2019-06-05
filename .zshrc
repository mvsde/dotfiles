export ZSH="/home/fynn/.oh-my-zsh"


# Theme
# https://github.com/denysdovhan/spaceship-prompt

ZSH_THEME="spaceship"

SPACESHIP_EXEC_TIME_PREFIX=""

SPACESHIP_EXIT_CODE_SHOW="true"
SPACESHIP_EXIT_CODE_SYMBOL="⨯ "


# Plugins

plugins=(
  docker
  docker-compose
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)


# Oh My Zsh configuration

HYPHEN_INSENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"


# Load Oh My Zsh

source $ZSH/oh-my-zsh.sh


# Environment variables

export LANG="en_US.UTF-8"
export EDITOR="nano"


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
