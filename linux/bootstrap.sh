sudo pacman -Syu
cat packages.txt | sudo pacman -S --needed -
if [[ -f "aur.txt" ]]; then
cat aur.txt | sudo paru -S --needed -
chezmoi init --apply https://github.com/burnskp/dotfiles.git
