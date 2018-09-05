#!/bin/bash

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return ;;
esac

# Basics ---------------------------------------------------------------------#

# Set history settings.
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# Set shell settings.
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

# Set localization settings.
export LANG="en_US"
export LC_ALL=$LANG.UTF-8

# Load alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load function definitions.
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Enable programmable completion features.
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Prompt ---------------------------------------------------------------------#

# Set variable identifying the chroot you work in.
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color).
case "$TERM" in
    xterm-color|*-256color) 
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ' ;;
    *)
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ ' ;;
esac

# If this is an xterm set the title to user@host:dir.
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1" ;;
    *) ;;
esac
