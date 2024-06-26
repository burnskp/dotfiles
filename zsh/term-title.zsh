#!/bin/zsh

typeset -a excluded_commands
excluded_commands=('ls' 'cd' 'echo' 'pwd', 'git', 'cat', 'bat')

function title-precmd() {
  if  git rev-parse --show-toplevel >/dev/null 2>&1; then
    GIT_BASE=$(basename $(git rev-parse --show-toplevel))
    print -Pn "\e]2;GIT - ${(q)GIT_BASE}\a"
  else
    print -Pn "\e]2;${PWD/#$HOME/~}\a"
  fi

  if [[ "$PWD" == "$HOME" ]]; then
    print -n "\ek~\e\\"
  else
    print -n "\ek${PWD##*/}\e\\"
  fi
}

function title-preexec() {
    cmd_name="${1%% *}"
    if [[ ! ${excluded_commands[(r)$cmd_name]} ]]; then
    print -n "\ek${cmd_name}\e\\"
     fi
}

autoload -Uz add-zsh-hook

add-zsh-hook -Uz precmd title-precmd
add-zsh-hook -Uz preexec title-preexec
