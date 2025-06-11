#!/bin/zsh

copy_terminfo() {
  if [ -f "/opt/homebrew/bin/ssh" ]; then
    SSH_BINARY="/opt/homebrew/bin/ssh"
  else
    SSH_BINARY="/usr/bin/ssh"
  fi

  if [ -f "/Applications/kitty.app/Contents/Resources/terminfo/78/xterm-kitty" ]; then
    $SSH_BINARY "$1" mkdir -p .terminfo/x
    scp /Applications/kitty.app/Contents/Resources/terminfo/78/xterm-kitty "$1":.terminfo/x/xterm-kitty
  elif [ -f "$HOME/.terminfo/78/xterm-kitty" ]; then
    ssh "$1" mkdir -p .terminfo/x
    scp "$HOME/.terminfo/78/xterm-kitty" "$1":.terminfo/x/xterm-kitty
  elif [ -f "$HOME/.terminfo/x/xterm-kitty" ]; then
    ssh "$1" mkdir -p .terminfo/x
    scp "$HOME/.terminfo/x/xterm-kitty" "$1":.terminfo/x/xterm-kitty
  else
    kitty +kitten ssh "$1" echo COPY terminfo
  fi
}
