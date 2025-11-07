#!/bin/bash
if [[ "$(uname -o)" == "GNU/Linux" ]]; then
  npm install -g "@anthropic-ai/claude-code"
fi
