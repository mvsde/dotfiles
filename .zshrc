export PATH="$PATH:$(yarn global bin)"
export ZSH="/home/fynn/.oh-my-zsh"
export DOCKER_HOST=tcp://0.0.0.0:2375

HIST_STAMPS="yyyy-mm-dd"

plugins=(
  docker
  docker-compose
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='nano'
fi

autoload -U promptinit; promptinit
prompt pure
