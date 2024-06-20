#!/bin/bash
linkFile() {
	if ! [ -L "$2" ]; then
		ln -s "$1" "$2"
	fi
}

./set-defaults.sh

if ! [ -f /opt/homebrew/bin/brew ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	chmod 755 /opt/homebrew/share
	sudo softwareupdate --install-rosetta
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle

if brew autoupdate status | grep -q 'Autoupdate is not configured'; then
	brew autoupdate start
fi

mkdir -p ~/.docker/cli-plugins
linkFile "$(brew --prefix)/bin/docker-buildx" ~/.docker/cli-plugins/docker-buildx

mkdir -p ~/.local/share

linkFile "$PWD/zshrc" ~/.zshrc
linkFile "$PWD/zshenv" ~/.zshenv

if ! [ -d ~/.config/bat ]; then
	mkdir -p ~/.config/bat/themes
	git clone https://github.com/wesbos/cobalt2.git ~/.config/bat/themes/cobalt2
	bat cache --build
fi

mkdir -p ~/.config/nvim

for i in nvim/*; do
	linkFile "$PWD/$i" "$HOME/.config/$i"
done

linkFile "$PWD/linters/cbfmt.toml" ~/.cbfmt.toml
linkFile "$PWD/linters/golangci.yml" ~/.golangci.yml
linkFile "$PWD/linters/markdownlintrc" ~/.markdownlintrc

mkdir -p ~/.config/yamllint
linkFile "$PWD/linters/yamllint.yml" ~/.config/yamllint/config

mkdir -p ~/.cache/zsh

mkdir -p ~/.config/karabiner
linkFile "$PWD/karabiner.json" "$HOME/.config/karabiner/karabiner.json"

linkFile "$PWD/wezterm.lua" "$HOME/.wezterm.lua"
linkFile "$PWD/starship.toml" "$HOME/.config/starship.toml"

linkFile ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/ ~/icloud

if ! [[ -f ~/.terminfo/77/wezterm ]]; then
	tempfile=$(mktemp) &&
		curl -o "$tempfile "https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo &&
		tic -x -o ~/.terminfo "$tempfile " &&
		rm "$tempfile"
fi
