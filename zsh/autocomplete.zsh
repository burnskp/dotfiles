#!/bin/zsh

FPATH="/opt/zsh/completions:$FPATH"

# Enable smart autocompletion
autoload -Uz compinit && compinit -u -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
setopt complete_in_word

# Setup fuzzy autocomplete
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

# Enable menu selection when hitting tab twice
zstyle ':completion:*' menu select

# group results by category
zstyle ':completion:*' group-name

# Set pid completion for kill
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -e -o pid,user,tty,cmd'

#Set Warning message when nothing can be autocompleted
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# Enable the use of auto completion cache to speed up some functions, such as pacman
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Allow 1 mistake in auto completion (fuzzy)
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Don't auto complete parent directory when using cd ../
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Disable user auto completion for ssh
zstyle ':completion:*:*:ssh*' users
zstyle ':completion:*:*:scp*' users

# Only complete hosts that are in the ~/.ssh/config file
zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Pass urls as literals if glob fails
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
url_commands=(curl scp rsync wget)
zstyle -e :urlglobber url-other-schema \
  '[[ $url_commands[(i)$words[1]] -le ${#url_commands} ]] && reply=("*") || reply=(http https ftp)'

if [ $commands[clusterctl] ]; then
  source <(clusterctl completion zsh)
fi

if [ $commands[flux] ]; then
  source <(flux completion zsh)
fi

if [ $commands[helm] ]; then
  source <(helm completion zsh)
fi

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

if [ $commands[kubecolor] ]; then
  compdef kubecolor=kubectl
fi

if [ $commands[talosctl] ]; then
  source <(talosctl completion zsh)
fi

if [ $commands[task] ]; then
  zstyle ':completion:*:*:task:*' verbose yes
  zstyle ':completion:*:*:task:*:descriptions' format '%U%B%d%b%u'
  zstyle ':completion:*:*:task:*' group-name ''
  compdef _task t=task
fi
