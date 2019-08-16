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


# mkcert for Node.js
# https://github.com/FiloSottile/mkcert#using-the-root-with-nodejs

export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"


# Node Version Manager

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


# Tilix Terminal Emulator

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte-2.91.sh
fi


# Aliases

alias code=codium
alias dc=docker-compose
alias weather="curl wttr.in"
alias moon="curl wttr.in/moon"


# Functions

function chpwd () {
  la
}
