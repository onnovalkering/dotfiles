#!/bin/bash

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return ;;
esac

# Common ---------------------------------------------------------------------#

source ~/.shellrc

# Config ---------------------------------------------------------------------#

shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

# Completion -----------------------------------------------------------------#

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Prompt ---------------------------------------------------------------------#

function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi