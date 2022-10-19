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
alias update-browserslist="npx browserslist@latest --update-db"


# Functions

function chpwd () {
  la
}

function suspendtime () {
  # Similar to 'uptime' but to get the suspend time.

  journalctl --boot | grep systemd-sleep
}

function groom-dependencies {
  # Source: https://kittygiraudel.com/2020/11/19/managing-npm-dependencies/
  # Requirements: jq (https://github.com/stedolan/jq)

  local key=${1:-dependencies}

  echo "(Maybe) unused dependencies:"

  for dep in $(cat package.json | jq -cr ".$key|keys|.[]"); do
    [[ -z "$(grep -r --exclude-dir=node_modules "'${dep}" .)" ]] && echo "  $dep";
  done
}

function groom-components {
  # Source: https://kittygiraudel.com/2020/11/18/looking-for-dead-code/

  local root="${2:-.}"

  echo "Unused components:"

  for entry in "$1"/*; do
    local name=$(basename $entry)

    if [[ -z "$(grep -r "/$name'" $root)" ]]; then
      echo "  $entry"
    fi
  done
}

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


# Load Starship prompt

eval "$(starship init zsh)"
