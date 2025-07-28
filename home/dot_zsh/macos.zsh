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

FPATH="/opt/homebrew/share/zsh-completions:$FPATH"
FPATH="/opt/homebrew/share/zsh/site-functions:$FPATH"
alias brewup='brew bundle install --file ~/.config/homebrew/Brewfile'
