export ZSH="/home/fynn/.oh-my-zsh"


# Theme
# https://github.com/denysdovhan/spaceship-prompt

ZSH_THEME="spaceship"


# Theme settings

SPACESHIP_EXEC_TIME_PREFIX="⌛ "
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

ENABLE_CORRECTION="true"
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


# Tilix Terminal Emulator

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte-2.91.sh
fi


# Aliases

alias code=codium

alias dc=docker-compose

alias weather="curl wttr.in"
alias moon="curl wttr.in/moon"

alias c="xclip -selection clipboard"
alias v="xclip -out"


# Functions

function chpwd () {
  la
}

function update-docker-compose () {
  local dc_path="/usr/local/bin/docker-compose"

  curl --silent https://api.github.com/repos/docker/compose/releases/latest \
    | grep --perl-regexp --only-matching "(?<=browser_download_url\": \").*`uname -s`-`uname -m`(?=\")" \
    | sudo wget --input-file - --output-document $dc_path

  sudo chmod +x $dc_path
}
