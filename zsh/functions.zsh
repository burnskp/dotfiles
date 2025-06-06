#!/bin/zsh

# Strip comments and empty lines out of a file
function catnc() {
  grep -E -v '(^#|^/)' "$1" | sed '/^$/d' | bat -p --pager=never
}

function diff() {
  if [ "$#" -ne 2 ]; then
    command diff "$@"
    return
  fi

  git diff --no-index $1 $2;
}

function cdgb() {
  if git rev-parse --show-toplevel >/dev/null 2>&1; then
    cd $(git rev-parse --show-toplevel)
  else
    echo "Not in a git repo."
  fi
}

if [[ $commands[git] ]]; then
  function gacmp () {
    git commit -a -m "$*" && git push origin HEAD
  }

  function gcmp () {
    git commit -m "$*" && git push origin HEAD
  }

  function gm () {
    if currentBranch=$(git symbolic-ref --short -q HEAD)
    then
      git checkout "$1"
      pull
      git checkout $currentBranch
      git rebase "$1"
    else
      echo not on any branch
    fi
  }

  function gpf() {
    if [ -z $1 ]
    then echo "Need the name of the branch"
    else
      if [ "$1" == "main" ]
      then echo "Can't force push to main"
      else
        git push --force-with-lease origin $1
      fi
    fi
  }

  function gss () {
    git stash && git checkout "$1" && git stash pop
  }

  function grm() {
    CURRENT=`git rev-parse --abbrev-ref HEAD` # figures out the current branch
    git checkout main
    git pull
    git checkout $CURRENT
    git rebase main
  }

  function gu() {
    git fetch $1 --prune; git merge --ff-only $1/$2 || git rebase --rebase=merges $1/$2;
  }

  function gsearch() {
    git rev-list --all | xargs git grep -F "$*"
  }
  function gpu() {
    git pull origin $(git rev-parse --abbrev-ref HEAD)
  }

  function fsb() {
    git fetch --prune
    local pattern=$*
      local branches branch
      branches=$(git branch --all | awk 'tolower($0) ~ /'"$pattern"'/') &&
      branch=$(echo "$branches" |
              fzf-tmux -p --reverse -1 -0 +m) &&
      if [ "$branch" = "" ]; then
          echo "[$0] No branch matches the provided pattern"; return;
    fi;
    git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
  }

  function fshow() {
    git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort --preview \
        'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1 ; }; f {}' \
      --header "enter to view, ctrl-o to checkout" \
      --bind "q:abort,ctrl-f:preview-page-down,ctrl-b:preview-page-up" \
      --bind "ctrl-o:become:(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs git checkout)" \
      --bind "ctrl-m:execute:
        (grep -o '[a-f0-9]\{7\}' | head -1 |
        xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
        {}
  FZF-EOF" --preview-window=right:60%
  }
fi

function ap() {
  awk "{print \$$1}"
}

if [ $commands[docker] ]; then
  function dshell() {
    docker exec -it $1 /bin/bash
  }
fi

