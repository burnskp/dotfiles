local M = {}

local wezterm = require("wezterm")
local act = wezterm.action

-- Configuration
local NOTES_DIR = (os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share")) .. "/notes"
local JOURNAL_DIR = NOTES_DIR .. "/journal"
local EXT = ".md"
local NVIM_CONFIG_PATH = wezterm.config_dir .. "/notes/note-nvim.lua"

-- Neovim configuration for note-taking mode
-- Uses :q on Esc instead of tmux detach (tab closes when nvim exits)
local NVIM_CONFIG = [[
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

vim.schedule(function()
  pcall(function() require('lualine').hide() end)
  vim.opt.laststatus = 0
  vim.api.nvim_set_keymap('n', '<Esc>', '<cmd>q<CR>', {noremap = true, silent = true})
end)
]]

-- Write the neovim config file once (persisted, not temp file each time)
local function ensure_nvim_config()
  local f = io.open(NVIM_CONFIG_PATH, "r")
  if f then
    local content = f:read("*a")
    f:close()
    if content == NVIM_CONFIG then
      return
    end
  end

  f = io.open(NVIM_CONFIG_PATH, "w")
  if f then
    f:write(NVIM_CONFIG)
    f:close()
  end
end

-- Initialize on module load
ensure_nvim_config()

-- Shell script for finding and editing notes
local function get_notes_script()
  return string.format([=[
set -e
NOTES_DIR="%s"
EXT="%s"
NVIM_CONFIG="%s"

mkdir -p "$NOTES_DIR"
cd "$NOTES_DIR"

result=$(FZF_DEFAULT_COMMAND="fd -I '$EXT'" \
  fzf --prompt="Find note: " \
  --preview="bat --style=plain --color=always --line-range=:40 {}" \
  --preview-window=up:40%%:wrap \
  --bind "ctrl-n:accept" \
  --bind "ctrl-g:reload:rg --no-ignore --ignore-case --files-with-matches {q} '**/*.md' 2>/dev/null || true" \
  --print-query | sed "s|$NOTES_DIR/||g" || true)

query=$(echo "$result" | sed -n '1p')
file=$(echo "$result" | sed -n '2p')

if [[ -n $file && -f $file ]]; then
  nvim --cmd "luafile $NVIM_CONFIG" +'nnoremap q :wq<CR>' "$file"
elif [[ -n $query ]]; then
  [[ $query == *$EXT ]] || query="${query}${EXT}"
  nvim --cmd "luafile $NVIM_CONFIG" +'nnoremap q :wq<CR>' "$NOTES_DIR/$query"
else
  exit 0
fi

git -C "$NOTES_DIR" add "$NOTES_DIR" 2>/dev/null || true
git -C "$NOTES_DIR" commit -m "Update notes" 2>/dev/null || true
git -C "$NOTES_DIR" push origin 2>/dev/null || true
]=], NOTES_DIR, EXT, NVIM_CONFIG_PATH)
end

-- Shell script for opening journal
local function get_journal_script()
  return string.format([=[
set -e
JOURNAL_DIR="%s"
NVIM_CONFIG="%s"

mkdir -p "$JOURNAL_DIR"
cd "$JOURNAL_DIR"

nvim --cmd "luafile $NVIM_CONFIG" -c "Journal" +'nnoremap q :wq<CR>'

git -C "$JOURNAL_DIR" add "$JOURNAL_DIR" 2>/dev/null || true
git -C "$JOURNAL_DIR" commit -m "Update notes" 2>/dev/null || true
git -C "$JOURNAL_DIR" push origin 2>/dev/null || true
]=], JOURNAL_DIR, NVIM_CONFIG_PATH)
end

M.action = {
  OpenNotes = wezterm.action_callback(function(window, pane)
    ensure_nvim_config()
    window:perform_action(act.SpawnCommandInNewTab({
      args = { "bash", "-c", get_notes_script() },
    }), pane)
  end),

  OpenJournal = wezterm.action_callback(function(window, pane)
    ensure_nvim_config()
    window:perform_action(act.SpawnCommandInNewTab({
      args = { "bash", "-c", get_journal_script() },
    }), pane)
  end),
}

return M
