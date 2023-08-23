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
  httpie
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
export STORYBOOK_DISABLE_TELEMETRY=1


# Aliases

alias la="exa --all --group-directories-first --classify --long --git --time-style long-iso"
alias lat="la --tree"
alias open=xdg-open
alias suspendtime="journalctl --boot | grep systemd-sleep"
alias update-browserslist="npx browserslist@latest --update-db"


# Functions

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

function update-ddev-completions () {
  local DDEV_VERSION=`ddev version --json-output | jq -r '.raw."DDEV version"'`
  local COMPLETIONS_ARCHIVE="ddev_shell_completion_scripts.${DDEV_VERSION}.tar.gz"
  local COMPLETIONS_FOLDER="$ZSH/completions"
  local TEMP_FOLDER=`mktemp --directory`

  mkdir --parents ${COMPLETIONS_FOLDER}

  curl --location https://github.com/ddev/ddev/releases/download/${DDEV_VERSION}/${COMPLETIONS_ARCHIVE} --remote-name --output-dir ${TEMP_FOLDER}
  tar --extract --file ${TEMP_FOLDER}/${COMPLETIONS_ARCHIVE} --directory ${TEMP_FOLDER}

  cp ${TEMP_FOLDER}/ddev_zsh_completion.sh ${COMPLETIONS_FOLDER}/_ddev
}
