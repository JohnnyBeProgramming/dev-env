#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# ---------------------------------------------------------------------------
# Helper commands
# ---------------------------------------------------------------------------
alias cls=clear
alias zshconfig="edit ~/.zshrc"
alias ohmyzsh="edit ~/.oh-my-zsh"
alias getmyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias python='python3'
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# Environment variables
# ---------------------------------------------------------------------------
export EDITOR='vim -w'

# Docker and docker-compose settings
export COMPOSE_HTTP_TIMEOUT=180
export DOCKER_BUILDKIT=1

# ---------------------------------------------------------------------------
# Add tab completion for SSH hostnames based on ~/.ssh/config
# ignoring wildcards
# ---------------------------------------------------------------------------
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
        -o "nospace" \
        -W "$(grep "^Host" ~/.ssh/config | \
        grep -v "[?*]" | cut -d " " -f2 | \
        tr ' ' '\n')" scp sftp ssh
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Go SDK
# ---------------------------------------------------------------------------
#export GOPATH=$HOME/Go
#export GOROOT=/usr/local/opt/go/libexec
#export PATH="$PATH:$GOPATH/bin"
#export PATH="$PATH:$GOROOT/bin"

# ---------------------------------------------------------------------------
# Path to your oh-my-zsh installation.
# ---------------------------------------------------------------------------
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="gozilla"
#ZSH_THEME="agnoster"

# Do NOT auto-switch (cd <folder>) when <folder> typed
unsetopt AUTO_CD

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# Set up auto completion for kubectl
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi

# ---------------------------------------------------------------------------
# Additional helper methods
# ---------------------------------------------------------------------------

function docker-stats() {
  docker stats $(docker ps -q)
}

function docker-dev-mail() {
  echo "Check mail at: http://localhost:1080"
  docker run --name=dev-mail -p 1080:80 -p 25:25 "djfarrelly/maildev"
}

function git-submodule-remove() {
  local target_dir=${1}

  [ "${target_dir}" == "" ] && echo "No target specified..." && exit 1;
  [ ! -d "${target_dir}" ] && echo "Submodule folder does not exists." && exit 1;

  echo "Moving '${target_dir}' to temp folder..."
  mv ${target_dir} ${target_dir}_old
  echo "De-initialising submodule..."
  git submodule deinit ${target_dir} || exit 1
  echo "Removing git folder '${target_dir}'..."
  git rm ${target_dir} || echo " - No git folder to remove..."
  git rm --cached ${target_dir} || echo " - Could not remove git cache for '${target_dir}'..."
  echo "Restoring folder contents back to original folder '${target_dir}'."
  mv ${target_dir}_old ${target_dir}
}
