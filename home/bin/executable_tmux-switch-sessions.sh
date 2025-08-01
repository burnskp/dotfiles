#!/bin/bash
repos="$HOME/git"

# catppuccin-latte
export FZF_DEFAULT_OPTS="--ansi --no-scrollbar \
--color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 \
--color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 \
--color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 \
--color=selected-bg:#BCC0CC --color=border:#CCD0DA,label:#4C4F69 \
--color=gutter:-1"

if [[ $# -eq 1 ]]; then
  selected=$1
else
  repo_list=$(find "$repos" -mindepth 1 -maxdepth 3 -type d -name .git | sed -e 's|'"${repos}"'/\(.*\)/.git|\1|' -e "s,/,: ,")
  selected=$(echo "$repo_list" | fzf --tmux --reverse --border-label="new session" -0 -1 +m)
fi

if [[ -z $selected ]]; then
  exit 0
fi

selected_name="${selected##*: }"
selected_path="${repos}/$(echo $selected | sed -e "s,: ,/,")"
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s "$selected_name" -c "$selected_path" nvim
  exit 0
fi

if ! tmux has-session -t="$selected_name" 2> /dev/null; then
  tmux new-session -ds "$selected_name" -c "$selected_path" nvim
  tmux new-window -dt "$selected_name" -c "$selected_path" -n "shell"
fi

tmux switch-client -t "$selected_name"
