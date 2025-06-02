#!/bin/zsh
export TERMINAL="st"
export COLORTERM="truecolor"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

umask 022

set -o noclobber
setopt nobeep
setopt completeinword
setopt correct
setopt extended_glob
setopt hash_list_all
setopt interactivecomments
setopt noflowcontrol
setopt nonomatch
setopt noshwordsplit
setopt prompt_subst

if [[ $commands[nvim] ]]; then
  export EDITOR="nvim"
else
  export EDITOR="vim"
fi

export BAT_THEME="catppuccin-latte"

if [[ -d /data ]]; then
  export HISTFILE="/data/.zsh_history"
else
  export HISTFILE="$HOME/.zsh_history"
fi
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."
export HISTSIZE=25000
export LESS=-R
export PAGER="less -R"
export SAVEHIST=25000

export EZA_COLORS=di=34:bd=33:cd=33:so=31:ex=32:ur=33:uw=31:ux=32:ue=32:uu=33:gu=33:lc=31:df=32:sn=32:nb=32:nk=32:nm=32:ng=32:nt=32

export ZAQ_PREFIXES=('git commit -m' 'doing now' 'dn' 'task add')

setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

checkpath=("/opt/bin" "/opt/rust/bin" "/opt/node/bin" $path)
if [ $commands[go] ]; then
  export GOPATH=/data/go
  export GOBIN=/data/go/bin
fi

for p in ${checkpath[@]}; do
  if [[ -d "$p" ]]; then
    path+="$p"
  fi
done

if [[ -S "$HOME/.ssh/split-ssh.sock" ]]; then
  export SSH_AUTH_SOCK="$HOME/.ssh/split-ssh.sock"
fi

typeset -U PATH
export PATH
