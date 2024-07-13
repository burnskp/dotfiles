#!/bin/zsh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# My dotfiles
for i in $HOME/git/dotfiles/zsh/*.zsh; do
  source "$i"
done

if [ -f "$HOME/.zshrc_local" ]; then
  source ~/.zshrc_local
fi

for i in $HOME/git/dotfiles/zsh/plugins/*.zsh; do
  source "$i"
done

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

for i in $HOME/git/dotfiles/zsh/plugins/last/*.zsh; do
  source "$i"
done

if [ $commands[rbenv] ]; then
  eval "$(rbenv init -)"
fi

if [[ -f /opt/homebrew/bin/brew ]]; then
  path=(${path[@]/\/opt\/homebrew\/bin})
  path=(${path[@]/\/opt\/homebrew\/sbin})
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
elif [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  path=(${path[@]/\/home\/linuxbrew\/.linuxbrew\/bin})
  path=(${path[@]/\/home\/linuxbrew\/.linuxbrew\/sbin})
  export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
fi

typeset -U PATH
