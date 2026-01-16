#!/usr/bin/env bash
set -e

# === WARNING SECTION ===
echo "=========================================================="
echo "WARNING: This script will AUTOMATICALLY INSTALL ARCH LINUX"
echo "on the drive you select and can ERASE ALL DATA on that drive."
echo
echo "What this script does:"
echo "- Creates a user (or root) account with the password you specify"
echo "- Wipes and partitions the drive you choose"
echo "- Installs the base system, i3 window manager, and essential packages"
echo "- Configures NetworkManager, Bluetooth, Pipewire audio, and multilib"
echo "- Sets up the bootloader (GRUB) for UEFI systems"
echo
echo "THIS ACTION IS DESTRUCTIVE. Make sure you have backups and"
echo "are selecting the correct drive."
echo "=========================================================="
read -rp "Do you want to continue? Type YES to proceed: " CONFIRM
if [[ "$CONFIRM" != "YES" ]]; then
    echo "Installation cancelled by user."
    exit 0
fi

echo "=== Inv's Automated ArchInstaller Script ==="

# Ask for username
read -rp "Enter the username to create: " USERNAME
read -rsp "Enter the password for $USERNAME: " PASSWORD
echo
read -rsp "Confirm password: " PASSWORD2
echo
if [ "$PASSWORD" != "$PASSWORD2" ]; then
    echo "Passwords do not match. Exiting."
    exit 1
fi

# Ask if user should be root
read -rp "Do you want to set this user as root? (y/N): " ROOTCHOICE
if [[ "$ROOTCHOICE" =~ ^[Yy]$ ]]; then
    USERNAME="root"
fi

# List drives for partitioning
echo "Available drives:"
lsblk -d -o NAME,SIZE,MODEL | grep -v loop
read -rp "Enter the drive to install Arch to (e.g., /dev/sda): " INSTALL_DRIVE

# Ask partitioning type
read -rp "Partitioning type: manual or best-effort? (manual/best): " PART_TYPE

# Ask mirror region
read -rp "Enter mirror region (e.g., US, DE, JP): " MIRROR_REGION

# Ask about mirror rank size
read -rp "Enter max number of mirrors to use (default 5): " MIRROR_COUNT
MIRROR_COUNT=${MIRROR_COUNT:-5}

# Prepare package list
PACKAGES=(
    "networkmanager"
    "bluez"
    "pipewire"
    "pipewire-pulse"
    "pipewire-alsa"
    "base-devel"
)
MULTILIB_PACKAGES=(
    "lib32-glibc"
    "lib32-gcc-libs"
)

# Generate JSON config
CONFIG_FILE="archinstall-config.json"
echo "Generating ArchInstall config at $CONFIG_FILE..."

cat > "$CONFIG_FILE" <<EOF
{
  "version": 1,
  "system": {
    "hostname": "arch",
    "timezone": "UTC",
    "locale": "en_US.UTF-8",
    "keyboard": "us"
  },
  "users": [
    {
      "username": "$USERNAME",
      "password": "$PASSWORD",
      "wheel": true,
      "sudo": true,
      "shell": "/bin/bash"
    }
  ],
  "disks": [
    {
      "device": "$INSTALL_DRIVE",
      "wipe": true,
      "layout": "$( [[ "$PART_TYPE" == "manual" ]] && echo "manual" || echo "best-effort" )"
    }
  ],
  "packages": [
    "i3-wm",
    "i3status",
    "dmenu",
    "alacritty",
    "xorg",
    "xorg-xinit",
    "networkmanager",
    "bluez",
    "pipewire",
    "pipewire-pulse",
    "pipewire-alsa",
    "base-devel"
  ],
  "multilib_packages": [
    "lib32-glibc",
    "lib32-gcc-libs"
  ],
  "bootloader": {
    "bootloader": "grub",
    "target": "x86_64-efi"
  },
  "network": {
    "hostname": "arch",
    "dhcp": true
  },
  "mirrors": {
    "countries": ["$MIRROR_REGION"],
    "max": $MIRROR_COUNT
  }
}
EOF

echo "Config generated: $CONFIG_FILE"

# Ask if user wants to run install now
read -rp "Run archinstall now? (y/N): " RUNNOW
if [[ "$RUNNOW" =~ ^[Yy]$ ]]; then
    archinstall --config "$CONFIG_FILE" --script
else
    echo "You can run it later with:"
    echo "archinstall --config $CONFIG_FILE --script"
fi
