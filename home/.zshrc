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
# ---------------------------------------------------------------------------

export EDITOR='vim -w'

export COMPOSE_HTTP_TIMEOUT=180
export DOCKER_BUILDKIT=1


# ---------------------------------------------------------------------------
# Set up auto completion for kubectl
# ---------------------------------------------------------------------------
if [ -f /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi


# ---------------------------------------------------------------------------
# Path to your oh-my-zsh installation.
# ---------------------------------------------------------------------------
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

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
