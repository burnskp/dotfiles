#!/usr/zsh
if [ "$(uname -o)" == "GNU/Linux" ] && grep -q Arch /etc/*release 2>&1 >/dev/null; then
  alias pac="sudo pacman -S"
  alias pacq="pacman -Q"
  alias pacr="sudo pacman -Rs"
  alias pacs="pacman -Ss"
  alias pacsy="sudo pacman -Sy"
  alias pacsyu="sudo pacman -Syu"
  alias pacu="sudo pacman -U"
  alias pacz="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
  alias pacrz="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
  alias paru="paru -S"
  alias parus="paru -Ss"
  alias paruu="paru -Su"
  alias paruy="paru -Syu"
fi
