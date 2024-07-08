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

source $(brew --prefix)/share/zsh-autopair/autopair.zsh

source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

source $(brew --prefix)/share/zsh-you-should-use/you-should-use.plugin.zsh
source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $(brew --prefix fzf)/shell/completion.zsh
source $(brew --prefix fzf)/shell/key-bindings.zsh

if [ $commands[rbenv] ]; then
  eval "$(rbenv init -)"
fi

if [[ /opt/homebrew/bin/brew ]]; then
  path=(${path[@]/\/opt\/homebrew\/bin})
  path=(${path[@]/\/opt\/homebrew\/sbin})
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
elif [[ /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  path=(${path[@]/\/home\/linuxbrew\/.linuxbrew\/bin})
  path=(${path[@]/\/home\/linuxbrew\/.linuxbrew\/sbin})
  export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
fi

typeset -U PATH
