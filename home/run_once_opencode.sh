#!/bin/bash
if [[ "$(uname -o)" == "GNU/Linux" ]]; then
  export BUN_INSTALL="$HOME/.local/share/bun"
  bun add -g opencode-ai
fi
