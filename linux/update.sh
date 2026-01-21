#!/usr/bin/env bash
set -e

pacman -Qqen > packages.txt
pacman -Qqem > aur.txt
