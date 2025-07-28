sudo pacman -Syu
cat server.packages | sudo pacman -S --needed -
if [[ $1 == "workstation" ]]; then
  cat workstation.packages | sudo pacman -S --needed -
fi
chezmoi init --apply https://github.com/burnskp/dotfiles.git
go install github.com/kubecolor/kubecolor@latest

# opencode
opencode_version=$(curl -s https://api.github.com/repos/sst/opencode/releases/latest \
  | awk -F'"' '/"tag_name": "/ {gsub(/^v/, "", $4); print $4}')
cd /tmp || exit 1
curl -sLo /tmp/oc.zip "https://github.com/sst/opencode/releases/download/v${opencode_version}/opencode-linux-x64.zip" \
  && unzip /tmp/oc.zip && mv opencode ~/bin \
  && rm /tmp/oc.zip

npm install -g @anthropic-ai/claude-code
