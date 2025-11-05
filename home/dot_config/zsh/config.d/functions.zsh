# Strip comments and empty lines out of a file
function catnc() {
  grep -E -v '(^#|^/)' "$1" | sed '/^$/d' | bat -p --pager=never
}

function diff() {
  if [ "$#" -ne 2 ]; then
    command diff "$@"
    return
  fi

  git diff --no-index $1 $2
}

function cdgb() {
  if git rev-parse --show-toplevel > /dev/null 2>&1; then
    cd $(git rev-parse --show-toplevel)
  else
    echo "Not in a git repo."
  fi
}

function addKeychainPass() {
  if ! [ "$1" ]; then
    echo "Usage: addKeyChainPass VARIABLE"
    return 1
  fi
  echo -n "Enter secret value: "
  read -s value
  security add-generic-password -a "$USER" -s "$1" -w "$value"
}

function setVariableFromKeychain() {
  if ! [ "$1" ]; then
    echo "Usage: setVariableFromKeychain VARIABLE"
    return 1
  fi
  export "$1"=$(security find-generic-password -a "$USER" -s "$1" -w)
}

if [[ $commands[chezmoi] ]]; then
  function chgacmp() {
    chezmoi git add . \
      && chezmoi git commit -- -m "$*" \
      && chezmoi git push origin HEAD
  }

  function chgcmp() {
    chezmoi git commit -- -m "$*" && chezmoi git push origin HEAD
  }
fi

function nn() {
  nvim -c CreateNote\ $1
}
