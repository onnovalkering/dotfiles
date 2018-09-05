#!/bin/bash

# Docker commands ------------------------------------------------------------#

alias drm='docker rm $(docker ps -a -q)'
alias drmi='docker rmi $(docker images -q)'

# Git commands ---------------------------------------------------------------#

alias ga='git add'
alias gb='git checkout'
alias gc='git commit'
alias gd='git diff'
alias gl='git ls-files'
alias go='git push origin'
alias gp='git pull'
alias gs='git status'

# Files commands -------------------------------------------------------------#

alias ~='cd ~'
alias ..='cd ../'
alias cp='cp -iv'
alias diff='colordiff'
alias grep='grep --colour=auto'
alias whereami='realpath .'
alias ls='ls -G -Flh --color=auto'
alias ll='ls -G -FlhA --color=auto'
alias mkdir='mkdir -pv'
alias mv='mv -iv'

# Networking commands --------------------------------------------------------#

alias fping='ping -c 100 -i .1'
alias ping='ping -c 5'
alias wget='wget -c'

# System commands ------------------------------------------------------------#

alias path='echo -e ${PATH//:/ \\n}'
alias sha1='openssl sha1'
