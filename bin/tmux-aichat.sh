#!/bin/bash

session="aichat"

oauth_token=$(cat ~/.config/github-copilot/apps.json | jq -r .[].oauth_token)
bearer_token=$(curl -sL https://api.github.com/copilot_internal/v2/token -H "Authorization: Bearer $oauth_token" -H "Content-Type: application/json" -H "Copilot-Integration-Id: vscode-chat" | jq -r ".token")
export bearer_token
yq -i '(.clients[].api_key) = strenv(bearer_token)' ~/.config/aichat/config.yaml
unset bearer_token

if ! tmux has -t "$session" 2> /dev/null; then
  session_id="$(tmux new-session -dP -s "$session" -F '#{session_id}' aichat)"
  tmux set-option -s -t "$session_id" key-table popup
  tmux set-option -s -t "$session_id" status off
  tmux set-option -s -t "$session_id" prefix None
  tmux set-option -s -t "$session_id" detach-on-destroy on
  tmux bind-key -T popup Escape detach-client
  session="$session_id"
fi

exec tmux attach -t "$session" > /dev/null
