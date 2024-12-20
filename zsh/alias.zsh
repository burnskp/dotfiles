#!/bin/zsh

alias grep="grep --color -i"
alias ndu="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias scpnh='scp -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null"'
alias sih="sudo -i -H"
alias sshnh='ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null"'
alias svi="sudo -e"
alias sz="source ~/.zshrc"
alias va='source .venv/bin/activate'
alias vi="nvim"
alias wget=wget --hsts-file="$HOME/.local/share/wget-hsts"

if [[ $commands[bat] ]]; then
  alias bathelp='bat --plain --language=help'
  alias bl="bat --paging=never -l log"
  alias cat='bat -p --paging=never'
  alias catl='bat --style header,snip,grid --pager=never'
  alias catp='bat --style header,snip,grid'
  alias diff="batdiff --delta"
  alias man="batman"
  alias pretty="prettybat"
  alias rg="batgrep -S"
  alias rgi="batgrep -i"
  alias rgs="batgrep -s"
  alias tf="tail -f | bat --paging=never -l log"

  function help() {
    "$@" --help 2>&1 | bathelp
  }
fi

if [[ $commands[eza] ]]; then
  alias la="eza -a --no-time --no-user --git --group-directories-first"
  alias ld="eza -D --no-time --no-user --git --group-directories-first"
  alias ldl="eza -lFD --no-time --no-user --git --group-directories-first"
  alias le="eza -lF --extended --no-time --no-user --git --group-directories-first"
  alias ll="eza -lF --no-time --no-user --git --group-directories-first"
  alias lla="eza --lFa --no-time --no-user --git --group-directories-first"
  alias ls="eza --no-time --no-user --git --group-directories-first"
  alias lsize="eza -lF --no-time --no-user --git --group-directories-first --sort=size"
  alias lt="eza -lF --no-user --git --group-directories-first"
  alias lu="eza -glF --git --group-directories-first"
fi

if  [ $commands[colima] ]; then
  if [[ $(($(sysctl -n hw.memsize) / 1024 / 1024 / 1024 )) -ge 64 ]]; then
    mem=32
    cpu=12
  else
    mem=4
    cpu=4
  fi
  if [[ $(uname -m) == "x86_64" ]]; then
    alias cs="colima start --arch aarch64 --vm-type=vz --cpu $cpu --memory $mem"
  else
    alias cs="colima start --arch aarch64 --vm-type=vz --vz-rosetta --cpu $cpu --memory $mem"
  fi
  alias cstop='colima stop'
fi

if  [ $commands[gsed] ]; then
  alias sed='gsed'
fi

if  [ $commands[talosctl] ]; then
  alias tcg="talosctl config contexts"
  alias tcu="talosctl config context"
  alias td="talosctl daskboard"
  alias tmem="talosctl memory"
fi

if [ $commands[docker] ]; then
  alias dcd='docker context describe'
  alias dci='docker context inspect'
  alias dcl='docker context ls'
  alias dcu='docker context use'
  alias dps='docker ps'
  alias dpsa='docker ps -a'
  alias dpsl='docker ps -l'
  alias drmi='docker rmi'
  alias drun='docker run'
  alias dexec='docker exec -it'
  alias dl='docker logs'
  alias dstop='docker stop'
fi

if [ "$TERM" == "wezterm" ]; then
  alias wsh="wezterm ssh"
fi

hash -d g="$HOME/exercism/go"
