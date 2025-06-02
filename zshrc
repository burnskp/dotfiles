#!/bin/zsh

if [[ $commands[zoxide] ]]; then
  eval "$(zoxide init zsh)"
fi

if [[ $commands[starship] ]]; then
  eval "$(starship init zsh)"
fi

# My dotfiles
for i in /opt/zsh/*.zsh; do
  source "$i"
done

for i in /opt/zsh/plugins/*.zsh; do
  source "$i"
done

source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

for i in /opt/zsh/plugins/last/*.zsh; do
  source "$i"
done

fast-theme catppuccin-latte

typeset -U PATH
