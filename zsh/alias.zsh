#!/bin/zsh

# global dot aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias grep="grep --color -i"
alias ndu="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias sih="sudo -i -H"
alias svi="sudo -e"
alias sz="source ~/.zshrc"
alias va='source .venv/bin/activate'
alias pacs='pacman -Ss'
alias pac='sudo pacman -S'

if [[ $commands[nvim] ]]; then
  alias vi="nvim"
else
  alias vi="vim"
fi

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

if  [ $commands[talosctl] ]; then
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

if [ $commands[excerism] ]; then
  hash -d g="/data/exercism/go"
fi

if  [ $commands[doing] ]; then
  alias ddone="doing done"
  alias dl="doing last"
  alias dn="doing done; doing now"
  alias dnow="doing now"
  alias dt="doing today --totals"
  alias dy="doing yesterday --totals"
fi

if  [ $commands[task] ]; then
  alias ta="task add"
  alias th="task history"
  alias tl="task ls"
  alias tln="task ls tag:next"
  alias tn="task next"
  alias tp="task projects"
  alias tsum="task summary"

  function td {
  task $1 done

  if grep -q "^taskd" $HOME/.config/task/taskrc; then
    task sync
  fi
}

function tlater {
  task $1 modify +later

  if grep -q "^taskd" $HOME/.config/task/taskrc; then
    task sync
  fi
}
function tdel {
  task $1 delete

  if grep -q "^taskd" $HOME/.config/task/taskrc; then
    task sync
  fi
}

function tap {
  task add project:$*

  if grep -q "^taskd" $HOME/.config/task/taskrc; then
    task sync
  fi
}

function tas {
  task add project:singletons $*

  if grep -q "^taskd" $HOME/.config/task/taskrc; then
    task sync
  fi
}

function tlp {
  task ls project:$*
}

function tdep {
  task $1 modify depends:"$2"

  if grep -q "^taskd" $HOME/.config/task/taskrc; then
    task sync
  fi
}

fi

if [ -n "$TMUX" ]; then
function set_win_title(){
  echo -ne "\033]0;$*\007"
}
function ssh() {
  TERM=xterm-256color
  tmux rename-window ${@[-1]}
  set_win_title ssh ${@[-1]}
  /usr/bin/ssh $*
  tmux setw automatic-rename
}

function sshnh() {
  TERM=xterm-256color
  tmux rename-window ${@[-1]}
  set_win_title ssh ${@[-1]}
  /usr/bin/ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null" $*
  tmux setw automatic-rename
}
else
alias scpnh='scp -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null"'
alias sshnh='ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null"'
fi

if [[ $commands[git] ]]; then
alias ga="git add"
alias gac="git commit -a "
alias gacm="git commit -a -m"
alias gap="git add -p"
alias gb="git branch"
alias gbl="git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format='%(refname:short)'"
alias gc="git commit -v"
alias gcam="git commit --amend"
alias gcb="git checkout -b"
alias gch="git checkout"
alias gcl="git clone"
alias gcm="git commit -m"
alias gd="git diff --color-moved"
alias gdm="git diff --color-moved origin/main"
alias gds="git diff --color-moved --staged"
alias gdt="git difftool"
alias gl="git log --graph --decorate"
alias gld="git log --all --graph --decorate --oneline --simplify-by-decoration"
alias glg="git log --graph --pretty=format:'%C(auto)%h -%d %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glf='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate --numstat'
alias glp="git log -p --decorate"
alias gls="git dlog"
alias gmt="nvim -c DiffviewOpen"
alias gmv="git mv"
alias gp='git push origin HEAD'
alias gpo='git push origin'
alias gpub='git pull --rebase=merges --prune origin'
alias grm="git rm"
alias grb="git rebase"
alias grh="git reset HEAD"
alias gs="git status -s"

# github functions
alias ghb="gh browse"
fi
