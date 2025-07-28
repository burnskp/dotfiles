if ! [ -f /opt/homebrew/bin/brew ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  chmod 755 /opt/homebrew/share
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

if brew autoupdate status | grep -q 'Autoupdate is not configured'; then
  brew autoupdate start
fi

brew install chezmoi

chezmoi init --apply https://github.com/burnskp/dotfiles.git
brew bundle ~/.config/homebrew/Brewfile
