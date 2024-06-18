#!/bin/zsh

alias diff="batdiff --delta"
alias df="duf --hide-mp '*ystem*olume*,*ecovery,/dev'"
alias du="dust -b"
alias grep="grep --color -i"
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
alias man="batman"
alias pretty="prettybat"
alias ping='prettyping --nolegend'
alias vi="nvim"
alias wget=wget --hsts-file="$HOME/.local/share/wget-hsts"

alias ndu="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias sih="sudo -i -H"
alias svi="sudo -e"
alias sz="source ~/.zshrc"

alias va='source .venv/bin/activate'

alias bathelp='bat --plain --language=help'
alias bl="bat --paging=never -l log"
alias cat='bat -p --pager=never'
alias catl='bat --style header,snip,grid --pager=never'
alias catp='bat --style header,snip,grid'
alias rg="batgrep -S"
alias rgi="batgrep -i"
alias rgs="batgrep -s"
alias tf="tail -f | bat --paging=never -l log"
function help() {
  "$@" --help 2>&1 | bathelp
}

alias scpnh='scp -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null"'
alias sshnh='ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null"'

if  [ $commands[colima] ]; then
  if [[ $(($(sysctl -n hw.memsize) / 1024 / 1024 / 1024 )) -ge 64 ]]; then
    alias cs='colima start --arch aarch64 --vm-type=vz --vz-rosetta --cpu 12 --memory 32'
  else
    alias cs='colima start --arch aarch64 --vm-type=vz --vz-rosetta --cpu 2 --memory 4'
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
fi
