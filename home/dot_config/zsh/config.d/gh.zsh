if [ $commands[gh] ]; then
  alias ghb="gh browse"
  alias ghpr="gh pr create -f"
  alias ghr='GH_PAGER="bat -p" gh run list --commit "$(git rev-parse HEAD)"'
  alias gho='gh repo view -w'
  alias ghw='gh run watch'

  alias gfb="gh f -b"
  alias gfg="gh f -g"
  alias gfl="gh f -l"
  alias gfk="gh f -k"
  alias gfp="gh f -p"
  alias gfr="gh f -r"
  alias gft="gh f -t"
fi
