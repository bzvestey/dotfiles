#!/usr/bin/env bash

set -euo pipefail

nixos_parent_folder="/etc/nixos"
device_parent_folder="$HOME/dev/dotfiles/device"

# Make sure the script isn't being run as the root user
if [ "$EUID" = "0" ]; then
    echo "❌ Error: This script must not be run as root (or with sudo)."
    exit 1
fi

# Ask the user for the device name
read -p "Please enter the device name (e.g., framework_16_nix): " device_name

# Make sure device name is not set to common
if [ "$device_name" = "common" ]; then
    echo "❌ Error: 'common' is not a valid device name."
    exit 1
fi

# Check if the input is empty
if [ -z "$device_name" ]; then
    echo "No device name entered. Exiting."
    exit 1
fi

# Verify the device folder exists
device_path="$device_parent_folder/$device_name"
if [ -e "$device_path" ]; then
    echo "✅ Device folder found: $device_path"
else
    echo "❌ ERROR: Device folder not found at $device_path"
    exit 1
fi

sudo cat <<EOF > "$nixos_parent_folder/setup_config.nix"
{ config, pkgs, ... }:

{
  # Install neovim for editing files
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  environment.systemPackages = with pkgs; [
    # Version control needed to pull down configs
    git
    jujutsu

    # Running commands
    just
  ];
}
EOF
