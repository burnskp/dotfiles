#!/bin/bash

session="aichat"

oauth_token=$(cat ~/.config/github-copilot/apps.json | jq -r .[].oauth_token)
bearer_token=$(curl -sL https://api.github.com/copilot_internal/v2/token -H "Authorization: Bearer $oauth_token" -H "Content-Type: application/json" -H "Copilot-Integration-Id: vscode-chat" | jq -r ".token")
export bearer_token
yq -i '(.clients[].api_key) = strenv(bearer_token)' ~/.config/aichat/config.yaml
unset bearer_token

if ! tmux has -t "$session" 2> /dev/null; then
  session_id="$(tmux new-session -dP -s "$session" -F '#{session_id}' aichat)"
  tmux set-option -s -t "$session_id" key-table aichat
  tmux set-option -s -t "$session_id" status off
  tmux set-option -s -t "$session_id" prefix C-space
  tmux set-option -s -t "$session_id" detach-on-destroy on
  tmux set-option -s -t "$session_id" setw -g mode-keys vi
  tmux set-option -s -t "$session_id" bind Space copy-mode
  tmux set-option -s -t "$session_id" bind C-Space copy-mode
  tmux set-option -s -t "$session_id" unbind p
  tmux set-option -s -t "$session_id" bind p paste-buffer
  tmux set-option -s -t "$session_id" bind-key -T copy-mode-vi 'v' send -X begin-selection
  tmux set-option -s -t "$session_id" bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel 'xsel -i -b'
  tmux set-option -s -t "$session_id" bind-key -T copy-mode-vi 'r' send -X rectangle-toggle
  tmux bind-key -T aichat Escape detach-client
  session="$session_id"
fi

exec tmux attach -t "$session" > /dev/null
