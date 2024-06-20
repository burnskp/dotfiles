#!/bin/zsh
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
fi
