#!/bin/zsh
NOTESDIR="/data/notes"

if [[ $commands[fzf] ]]; then
  source <(fzf --zsh)
  export FZF_DEFAULT_OPTS="--style full --ansi --no-scrollbar \
--color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 \
--color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 \
--color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 \
--color=selected-bg:#BCC0CC \
--color=border:#CCD0DA,label:#4C4F69"

  alias fp="fzf --ansi --style full --preview 'bat --color=always --style=plain {}' --no-scrollbar"

  function fn() {
    /usr/bin/rg --color=always --line-number --no-heading --smart-case "${*:-}" "$NOTESDIR" |
      fzf --ansi \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
        --bind 'enter:become(nvim {1} +{2})'
    }

    function fr() {
      /usr/bin/rg --color=always --line-number --no-heading --smart-case "${*:-}" |
        fzf --ansi \
          --color "hl:-1:underline,hl+:-1:underline:reverse" \
          --delimiter : \
          --preview 'bat --color=always {1} --highlight-line {2}' \
          --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
          --bind 'enter:become(nvim {1} +{2})'
      }
    fi

    function gpr() {
      fzf --tmux 80%,100% --ansi \
        --border vertical --info inline --reverse --header-lines 4 \
        --preview 'GH_FORCE_TTY=$FZF_PREVIEW_COLUMNS gh pr view --comments {1}' \
        --preview-window up:border-down \
        --with-shell 'bash -c' \
        --bind 'start:preview(echo Loading pull requests ...)+reload:GH_FORCE_TTY=$((FZF_COLUMNS-3)) gh pr list --limit=1000' \
        --bind 'load:transform:(( FZF_TOTAL_COUNT )) || echo become:echo No pull requests' \
        --bind 'ctrl-o:execute-silent:gh pr view --web {1}' \
        --bind 'enter:become:gh pr checkout {1}' "$@"
    }

    function grc() {
      local file
      file=$(git log --all --pretty=format: --name-only | sort -u | grep -v '^$' | \
        fzf --prompt="Select file: ")
        [[ -z $file ]] && return

        local commit
        commit=$(git log --oneline -- $file | \
            fzf --preview "git show {1}:$file | bat --style=numbers --color=always --line-range :500 - 2>/dev/null || echo 'File deleted in this commit'" \
            --prompt="Select commit: " \
            --delimiter=' ' \
            --with-nth=1,2.. \
            --preview-window=up:60%:wrap \
          | awk '{print $1}')
          [[ -z $commit ]] && return

          git checkout "$commit" -- "$file"
        }

        function gr() {
          repos="/data/git"

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
          cd "$selected_path"
        }
