export ZSH="/home/fynn/.oh-my-zsh"


# Theme
# https://github.com/spaceship-prompt/spaceship-prompt

ZSH_THEME="spaceship"


# Theme settings

SPACESHIP_PROMPT_DEFAULT_PREFIX="· "
SPACESHIP_DOCKER_PREFIX="· "
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

alias update-browserslist="npx browserslist@latest --update-db"

alias c="xclip -selection clipboard"
alias v="xclip -out"


# Functions

function chpwd () {
  la
}

function suspendtime () {
  # Similar to 'uptime' but to get the suspend time.

  cat /var/log/syslog | grep "systemd-sleep" | grep "Suspending system...\|System resumed."
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

  for THEME in $ZSH/custom/themes/*/; do
    cd $THEME
    pwd
    git pull
    cd ..
  done

  cd $CWD
}
