#!/usr/bin/env bash
set -e

echo "> Installing Inv's Light-Weight Template..."

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm \
  i3-wm i3status dmenu alacritty 

echo "> 'startx' to start."
