#!/usr/bin/env zsh

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return ;;
esac

# Common ---------------------------------------------------------------------#

source ~/.shellrc

# Config ---------------------------------------------------------------------#

setopt autocd
setopt correct
setopt extendedglob
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Plugins --------------------------------------------------------------------#

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Prompt ---------------------------------------------------------------------#

autoload -U promptinit
promptinit
prompt adam1

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
