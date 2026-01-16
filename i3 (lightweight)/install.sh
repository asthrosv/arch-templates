#!/usr/bin/env bash
set -e

echo "> Installing Inv's Light-Weight Template..."

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm \
  i3-wm i3status dmenu alacritty xorg-xinit

# Create .xinitrc for i3
echo "exec i3" > ~/.xinitrc

# Optional: auto-login on TTY1 and start X
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $USER --noclear %I \$TERM
EOF

echo "> Done! Reboot to automatically start i3."
