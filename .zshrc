#!/bin/zsh

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return ;;
esac

# Common ---------------------------------------------------------------------#

source ~/.shellrc

# Config ---------------------------------------------------------------------#

# Completion -----------------------------------------------------------------#

fpath=(/usr/local/share/zsh-completions $fpath)

autoload -U compinit
compinit

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Prompt ---------------------------------------------------------------------#

function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi
