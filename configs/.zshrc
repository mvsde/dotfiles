export ZSH="/home/fynn/.oh-my-zsh"


# Node Version Manager

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


# zsh plugins

plugins=(
  docker
  docker-compose
  git
  npm
  starship
  yarn
  z
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


# Aliases

alias la="exa --all --group-directories-first --classify --long --git --time-style long-iso"
alias lat="la --tree"
alias open=xdg-open
alias suspendtime="journalctl --boot | grep systemd-sleep"
alias update-browserslist="npx browserslist@latest --update-db"


# Functions

function update-docker-compose () {
  local INSTALL_PATH="/usr/local/bin/docker-compose"

  curl --silent https://api.github.com/repos/docker/compose/releases/latest \
    | grep --perl-regexp --only-matching "(?<=browser_download_url\": \").+/docker-compose-linux-x86_64(?=\")" \
    | sudo wget --input-file - --output-document $INSTALL_PATH

  sudo chmod +x $INSTALL_PATH
}

function update-zsh-custom () {
  local CWD=`pwd`

  for PLUGIN in $ZSH/custom/plugins/*/; do
    cd $PLUGIN
    pwd
    git pull
    cd ..
  done

  cd $CWD
}
