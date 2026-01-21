#!/bin/bash
set -e

# Ensure we're not running as root (AUR helpers need regular user)
if [[ $EUID -eq 0 ]]; then
  echo "Error: This script should not be run as root"
  exit 1
fi

# Check if running on Arch-based system
if ! command -v pacman &> /dev/null; then
  echo "Error: This script requires an Arch-based system with pacman"
  exit 1
fi

if ! command -v ansible &> /dev/null; then
  echo "Ansible not found. Installing..."
  sudo pacman -Syu --noconfirm ansible
  ansible-galaxy collection install community.general
fi

ansible-playbook playbook.yml --ask-become-pass

if [[ -f "aur.txt" ]]; then
  paru -S --needed - < aur.txt
fi
