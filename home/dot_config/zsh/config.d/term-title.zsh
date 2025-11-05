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
  if [[ ! ${excluded_commands[$cmd_name]} ]]; then
    print -n "\ek${cmd_name}\e\\"
  fi
}

autoload -Uz add-zsh-hook

add-zsh-hook -Uz precmd title-precmd
add-zsh-hook -Uz preexec title-preexec

ssh_with_title() {
  # Extract the hostname from the SSH command
  local hostname
  skip_next=false
  for arg in "$@"; do
    if $skip_next; then
      skip_next=false
      continue
    fi

    case "$arg" in
      -*)
        # Check if this option takes an argument
        if [[ $arg =~ ^-[bcDEeFIiLlmOopQRSWw]$ ]]; then
          skip_next=true
        fi
        ;;
      *@*)
        # user@hostname format
        hostname="${arg#*@}"
        break
        ;;
      *)
        # Assume it's the hostname
        hostname="$arg"
        break
        ;;
    esac
  done

  # Remove any port number from the hostname
  hostname=${hostname%:*}

  if [ "$TERM" == wezterm ]; then
    TERM=xterm
  fi
  echo -ne "\033]0;s:$hostname\007"
  command ssh "$@"
}

alias ssh="ssh_with_title"
