# ------------------------------------------------------------------------------
# zsh
# ------------------------------------------------------------------------------

export ZSH="/home/fynn/.oh-my-zsh"

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

source "$ZSH/oh-my-zsh.sh"


# ------------------------------------------------------------------------------
# nvm
# ------------------------------------------------------------------------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


# ------------------------------------------------------------------------------
# Environment variables
# ------------------------------------------------------------------------------

export LANG="en_US.UTF-8"
export EDITOR="code --wait"

# Telemetry

export ASTRO_TELEMETRY_DISABLED=1
export GATSBY_TELEMETRY_DISABLED=1
export NEXT_TELEMETRY_DISABLED=1
export NUXT_TELEMETRY_DISABLED=1
export STORYBOOK_DISABLE_TELEMETRY=1


# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------

alias la="eza --all --group-directories-first --classify --long --git --time-style long-iso"
alias lat="la --tree"
alias ncu="npx npm-check-updates@latest"
alias nr="node --run"
alias open="xdg-open"
alias serve="npx serve@latest"
alias suspendtime="journalctl --boot | grep systemd-sleep"
alias update-browserslist="npx browserslist@latest --update-db"
alias github-toc="bitdowntoc --profile=GITHUB --indent-chars=- --indent-spaces=2 --inplace"


# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

# Update scripts

function update-zsh-custom () {
  echo "Updating zsh custom…"

  for PLUGIN in "${ZSH}/custom/plugins"/*; do
    (
      cd "$PLUGIN" || exit
      pwd
      git pull
    )
  done

  echo "Updated zsh custom"
}

function update-git-open () {
  echo "Updating git-open…"

  local TEMP_FOLDER

  TEMP_FOLDER=$(mktemp --directory)

  curl --silent --show-error "https://raw.githubusercontent.com/paulirish/git-open/master/git-open" --output "${TEMP_FOLDER}/git-open"
  chmod +x "${TEMP_FOLDER}/git-open"

  sudo mv "${TEMP_FOLDER}/git-open" "/usr/local/bin"

  echo "Updated git-open"
}

function update-ddev-completions () {
  echo "Updating DDEV completions…"

  local DDEV_VERSION
  local ARCHIVE_NAME
  local TEMP_FOLDER

  DDEV_VERSION=$(
    ddev version --json-output |
    jq --raw-output '.raw."DDEV version"'
  )
  ARCHIVE_NAME="ddev_shell_completion_scripts.${DDEV_VERSION}.tar.gz"
  TEMP_FOLDER=$(mktemp --directory)

  curl --silent --show-error --location "https://github.com/ddev/ddev/releases/download/${DDEV_VERSION}/${ARCHIVE_NAME}" --remote-name --output-dir "${TEMP_FOLDER}"
  tar --extract --file "${TEMP_FOLDER}/${ARCHIVE_NAME}" --directory "${TEMP_FOLDER}"

  cp "${TEMP_FOLDER}/ddev_zsh_completion.sh" "${ZSH}/completions/_ddev"

  echo "Updated DDEV completions"
}

function update-doggo () {
  echo "Updating doggo…"

  local ARCHIVE_URL
  local TEMP_FOLDER

  ARCHIVE_URL=$(
    curl --silent --show-error "https://api.github.com/repos/mr-karan/doggo/releases/latest" |
    jq --raw-output '.assets[] | select(.name? | match("doggo_.+_linux_amd64.tar.gz$")) | .browser_download_url'
  )
  TEMP_FOLDER=$(mktemp --directory)

  curl --silent --show-error --location "${ARCHIVE_URL}" --output "${TEMP_FOLDER}/doggo.tar.gz"
  tar --extract --file "${TEMP_FOLDER}/doggo.tar.gz" --directory "${TEMP_FOLDER}"

  sudo mv "${TEMP_FOLDER}/doggo" "/usr/local/bin"

  curl --silent --show-error "https://raw.githubusercontent.com/mr-karan/doggo/main/completions/doggo.zsh" --output "${ZSH}/completions/_doggo"

  echo "Updated doggo"
}

function update-bitdowntoc () {
  echo "Updating bitdowntoc…"

  local BINARY_URL
  local TEMP_FOLDER

  BINARY_URL=$(
    curl --silent --show-error "https://api.github.com/repos/derlin/bitdowntoc/releases/latest" |
    jq --raw-output '.assets[] | select(.name=="bitdowntoc_linux") | .browser_download_url'
  )
  TEMP_FOLDER=$(mktemp --directory)

  curl --silent --show-error --location "${BINARY_URL}" --output "${TEMP_FOLDER}/bitdowntoc"
  chmod +x "${TEMP_FOLDER}/bitdowntoc"

  sudo mv "${TEMP_FOLDER}/bitdowntoc" "/usr/local/bin"

  echo "Updated bitdowntoc"
}

function update-browserstack-local () {
  echo "Updating BrowserStackLocal…"

  local TEMP_FOLDER

  TEMP_FOLDER=$(mktemp --directory)

  curl --silent --show-error "https://www.browserstack.com/browserstack-local/BrowserStackLocal-linux-x64.zip" --remote-name --output-dir "${TEMP_FOLDER}"
  unzip "${TEMP_FOLDER}/BrowserStackLocal-linux-x64.zip" -d "${TEMP_FOLDER}"

  sudo mv "${TEMP_FOLDER}/BrowserStackLocal" "/usr/local/bin"

  echo "Updated BrowserStackLocal"
}

function update-all () {
  omz update

  update-ddev-completions
  update-doggo
  update-git-open
  update-bitdowntoc
  update-browserstack-local
  update-zsh-custom

  curl --silent --show-error https://starship.rs/install.sh | sh
}

# Commands

function git-pull-all () {
  git branch --remotes | grep -v '\->' | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | while read -r remote; do git branch --track "${remote#origin/}" "$remote"; done
  git fetch --all
  git pull --all
}
