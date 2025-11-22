#!/usr/zsh
if [ "$(uname -o)" == "GNU/Linux" ] && grep -q Arch /etc/*release 2>&1 >/dev/null; then
  export UV_LINK_MODE=copy
  export BROWSER=helium-browser
  alias pac="sudo pacman -S"
  alias paci="pacman -Si"
  alias pacq="pacman -Q"
  alias pacr="sudo pacman -Rs"
  alias pacrz="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
  alias pacs="pacman -Ss"
  alias pacsy="sudo pacman -Sy"
  alias pacsyu="sudo pacman -Syu"
  alias pacu="sudo pacman -U"
  alias pacz="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
  alias parus="paru -Ss"
  alias paruu="paru -Su"
  alias paruy="paru -Syu"
  alias scu='systemctl --user'
  alias ju='journalctl --user -u'
fi
