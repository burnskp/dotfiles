sudo pacman -Syu
cat packages.txt | sudo pacman -S --needed -
chezmoi init --apply https://github.com/burnskp/dotfiles.git
go install github.com/kubecolor/kubecolor@latest
