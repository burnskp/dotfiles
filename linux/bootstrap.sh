#!/bin/bash
set -e
if ! command -v ansible &> /dev/null; then

  echo "Ansible not found. Installing..."
  sudo pacman -Syu --noconfirm ansible
  ansible-galaxy collection install community.general
fi

ansible-playbook playbook.yml --ask-become-pass

if [[ -f "aur.txt" ]]; then
  cat aur.txt | sudo paru -S --needed -
fi
