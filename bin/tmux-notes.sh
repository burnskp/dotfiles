#!/usr/bin/env bash

NOTES_DIR="/data/notes"
EXT=".md"

mkdir -p "$NOTES_DIR"

# Lua code to set note-friendly options
read -r -d '' NOTE_LUA << 'EOF'
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.signcolumn = "no"
vim.diagnostic.enable(false, { bufnr = 0 })
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = "nc"
vim.opt_local.foldenable = false
vim.opt_local.spell = true
vim.opt_local.textwidth = 80

vim.schedule(
  function()
    require('lualine').hide()
    vim.opt.laststatus = 0
  end
)
EOF

select_note() {
  local result
  result=$(FZF_DEFAULT_COMMAND="ls $NOTES_DIR/*.md 2>/dev/null" \
    fzf --prompt="Find note: " \
    --preview="bat --style=plain --color=always --line-range=:40 {}" \
    --preview-window=up:40%:wrap \
    --bind "ctrl-n:accept" \
    --bind "ctrl-g:reload:rg --ignore-case --files-with-matches {q} $NOTES_DIR/*.md 2>/dev/null || true" \
    --print-query)

  echo "$result"
}
grep_notes() {
  RG_PREFIX="rg --ignore-case --files-with-matches {q} $NOTES_DIR/*.md"
  fzf --prompt="Grep notes: " --bind "start:reload:$RG_PREFIX" \
    --bind "change:reload:$RG_PREFIX|| true" \
    --preview="bat --style=plain --color=always --line-range=:40 {}" \
    --preview-window=up:60%:wrap \
    --ansi --disabled \
    --print-query
}

main() {
  local result query file
  if [ "$1" == "grep" ]; then
    result=$(grep_notes)
  else
    result=$(select_note)
  fi

  query=$(echo "$result" | sed -n '1p')
  file=$(echo "$result" | sed -n '2p')

  # Write the Lua config to a temp file
  local lua_tmp
  lua_tmp=$(mktemp /tmp/note_lua.XXXXXX.lua)
  echo "$NOTE_LUA" > "$lua_tmp"

  if [[ -n $file && -f $file ]]; then
    nvim --cmd "luafile $lua_tmp" +'nnoremap q :wq<CR>' "$file"
  elif [[ -n $query ]]; then
    [[ $query == *$EXT ]] || query="${query}${EXT}"
    local newfile="$NOTES_DIR/$query"
    nvim --cmd "luafile $lua_tmp" +'nnoremap q :wq<CR>' "$newfile"
  fi

  rm -f "$lua_tmp"
}

main $1
