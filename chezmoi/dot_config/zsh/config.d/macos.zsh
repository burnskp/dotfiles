FPATH="/opt/homebrew/share/zsh-completions:$FPATH"
FPATH="/opt/homebrew/share/zsh/site-functions:$FPATH"

function addKeychainPass() {
  if ! [ "$1" ]; then
    echo "Usage: addKeyChainPass VARIABLE"
    return 1
  fi
  local value
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
