typeset -a excluded_commands
excluded_commands=('ls' 'cd' 'echo' 'pwd', 'git', 'cat', 'bat')

function title-precmd() {
  if [[ $PWD == "$HOME" ]]; then
    print -n "\ekd:~\e\\"
  else
    print -n "\ekd:${PWD##*/}\e\\"
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
