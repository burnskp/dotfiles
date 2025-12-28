alias grep="grep --color -i"
alias Grep="grep --color -i"
alias ndu="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias scpnh='scp -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null"'
alias sih="sudo -i -H"
alias sshnh='ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null"'
alias svi="sudo -e"
alias sz="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias va='source .venv/bin/activate'
alias vi="nvim"
alias mi="NVIM_MINIMAL=true nvim"
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

alias fn="nvim -c Notes"
alias gn="nvim -c NotesGrep"

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

if [ $commands[gsed] ]; then
  alias sed='gsed'
fi

if [ $commands[talosctl] ]; then
  alias tcg="talosctl config contexts"
  alias tcu="talosctl config context"
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

if [[ $commands[chezmoi] ]]; then
  alias cha="chezmoi add"
  alias chap="chezmoi apply"
  alias chcd="chezmoi cd"
  alias chd="chezmoi diff"
  alias che="chezmoi edit"
  alias chg="chezmoi git --"
  alias chga="chezmoi git add"
  alias chgac="chezmoi git add .; chezmoi git commit"
  alias chgacp="chezmoi git add .; chezmoi git commit && chezmoi git push"
  alias chgc="chezmoi git commit"
  alias chgcm="chezmoi git commit -- -m"
  alias chgcp="chezmoi git commit && chezmoi git push"
  alias chgp="chezmoi git push origin HEAD"
  alias chgs="chezmoi git status"
  alias chm="chezmoi merge"
  alias chr="chezmoi re-add"
  alias chs="chezmoi status"
  alias chu="chezmoi update"
  alias chum="chezmoi unmanaged"
fi
