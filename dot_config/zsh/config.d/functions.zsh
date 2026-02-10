# Strip comments and empty lines out of a file
function catnc() {
  grep -E -v '(^#|^/)' "$1" | sed '/^$/d' | bat -p --pager=never
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
