#!/usr/bin/env bash

# bootstrap.sh
# Sets up a NixOS or macOS host from this configuration.
# Usage: curl -L <raw-url> | bash

REPO_URL="https://github.com/bzvestey/dotfiles"
REPO_DIR="$HOME/dev/dotfiles"

# ANSI Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log() { echo -e "${BLUE}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
err() { echo -e "${RED}[ERROR]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }

# Detect OS
OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
else
    err "Unsupported operating system: $OSTYPE"
    exit 1
fi

log "Detected operating system: $OS"

# 1. Install Git if missing
if ! command -v git &> /dev/null; then
    log "Git not found. Entering nix-shell to use git..."
    # Rerun this script inside nix-shell with git
    exec nix-shell -p git --run "$(printf '%q ' "$0" "$@")"
fi

# 2. Clone Repository
if [ -d "$REPO_DIR" ]; then
    log "Repository already exists at $REPO_DIR."
    read -p "Do you want to pull the latest changes? (y/N) " pull_choice
    if [[ "$pull_choice" =~ ^[Yy]$ ]]; then
        cd "$REPO_DIR" || exit
        git pull
    fi
else
    log "Cloning repository to $REPO_DIR..."
    mkdir -p "$(dirname "$REPO_DIR")"
    git clone "$REPO_URL" "$REPO_DIR"
fi

cd "$REPO_DIR" || exit

echo ""
echo "------------------------------------------------"
if [ "$OS" == "linux" ]; then
    echo "  NixOS Configuration Bootstrap"
else
    echo "  macOS (nix-darwin) Configuration Bootstrap"
fi
echo "------------------------------------------------"
echo "1) Apply Existing Host Configuration"
echo "2) Create New Host Configuration"
echo "------------------------------------------------"
read -p "Select an option [1-2]: " choice

if [ "$choice" == "1" ]; then
    # Existing Host
    log "Available hosts:"
    if [ "$OS" == "linux" ]; then
        ls -1 hosts/ | grep -v "darwin" 2>/dev/null || ls hosts/
    else
        ls -1 hosts/ | grep "darwin" 2>/dev/null || ls hosts/
    fi

    echo ""
    read -p "Enter hostname to apply: " hostname

    if [ ! -d "hosts/$hostname" ]; then
        err "Host '$hostname' not found in hosts/ directory!"
        exit 1
    fi

    log "Applying configuration for '$hostname'..."

    if [ "$OS" == "linux" ]; then
        # Linux/NixOS
        if command -v just &> /dev/null; then
            just switch host="$hostname"
        else
            log "'just' not found, using nixos-rebuild directly..."
            sudo nixos-rebuild switch --flake .#"$hostname"
        fi
    else
        # macOS/nix-darwin
        if command -v just &> /dev/null; then
            just switch-darwin host="$hostname"
        elif command -v darwin-rebuild &> /dev/null; then
            darwin-rebuild switch --flake .#"$hostname"
        else
            warn "darwin-rebuild not found. Make sure nix-darwin is installed."
            warn "You may need to install nix-darwin first:"
            warn "  nix run nix-darwin -- switch --flake .#$hostname"
            exit 1
        fi
    fi

    success "Configuration applied successfully!"

elif [ "$choice" == "2" ]; then
    # New Host
    read -p "Enter new hostname: " hostname

    if [ -d "hosts/$hostname" ]; then
        err "Host directory 'hosts/$hostname' already exists!"
        exit 1
    fi

    log "Creating host directory..."
    mkdir -p "hosts/$hostname"

    if [ "$OS" == "linux" ]; then
        # Linux/NixOS New Host
        # Get Hardware Config
        if [ -f /etc/nixos/hardware-configuration.nix ]; then
            log "Copying /etc/nixos/hardware-configuration.nix..."
            cp /etc/nixos/hardware-configuration.nix "hosts/$hostname/hardware.nix"
        else
            warn "/etc/nixos/hardware-configuration.nix not found."
            log "Generating new hardware configuration..."
            if command -v nixos-generate-config &> /dev/null; then
                sudo nixos-generate-config --dir /tmp/nixos-config-gen
                cp /tmp/nixos-config-gen/hardware-configuration.nix "hosts/$hostname/hardware.nix"
                sudo rm -rf /tmp/nixos-config-gen
            else
                 err "nixos-generate-config not found. Cannot generate hardware config."
                 exit 1
            fi
        fi

        # Create default.nix
        log "Creating default.nix..."
        # Determine state version (fallback to 24.11 if detection fails)
        STATE_VERSION=$(nixos-version | cut -d. -f1-2 2>/dev/null || echo "24.11")

        cat > "hosts/$hostname/default.nix" <<EOF
{ config, pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    # Import core modules
    ../../modules/nixos/core/base.nix
    ../../modules/nixos/core/users.nix

    # Add other modules here (e.g. desktop environment, services)
  ];

  networking.hostName = "$hostname";

  system.stateVersion = "$STATE_VERSION";
}
EOF

        success "Created configuration files in hosts/$hostname/"

        # Instructions for flake.nix
        echo ""
        warn "ACTION REQUIRED: You must manually add the host to flake.nix"
        echo "---------------------------------------------------------------"
        echo "Edit flake.nix and add the following inside 'nixosConfigurations':"
        echo ""
        echo "      $hostname = nixpkgs.lib.nixosSystem {"
        echo "        system = linuxSystem;"
        echo "        specialArgs = { inherit inputs; };"
        echo "        modules = ["
        echo "          { nixpkgs.overlays = [ localpkgs.overlays.default ]; }"
        echo "          ./hosts/$hostname/default.nix"
        echo "          agenix.nixosModules.default"
        echo "          home-manager.nixosModules.home-manager"
        echo "          {"
        echo "            home-manager.useGlobalPkgs = true;"
        echo "            home-manager.useUserPackages = true;"
        echo "            home-manager.users.\${homeManagerUser} = homeManagerConfig;"
        echo "            home-manager.extraSpecialArgs = { inherit inputs; };"
        echo "          }"
        echo "        ];"
        echo "      };"
        echo "---------------------------------------------------------------"
        echo ""
        log "After editing flake.nix, run: sudo nixos-rebuild switch --flake .#$hostname"

    else
        # macOS/nix-darwin New Host
        log "Creating macOS configuration..."

        cat > "hosts/$hostname/default.nix" <<EOF
{ config, pkgs, inputs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # \$ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  # Nix settings
  nix.settings.experimental-features = "nix-command flakes";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # \$ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
EOF

        success "Created configuration files in hosts/$hostname/"

        # Instructions for flake.nix
        echo ""
        warn "ACTION REQUIRED: You must manually add the host to flake.nix"
        echo "---------------------------------------------------------------"
        echo "Edit flake.nix and add the following inside 'darwinConfigurations':"
        echo ""
        echo "      $hostname = nix-darwin.lib.darwinSystem {"
        echo "        system = darwinSystem;"
        echo "        specialArgs = { inherit inputs; };"
        echo "        modules = ["
        echo "          { nixpkgs.overlays = [ localpkgs.overlays.default ]; }"
        echo "          ./hosts/$hostname/default.nix"
        echo "          home-manager.darwinModules.home-manager"
        echo "          {"
        echo "            home-manager.useGlobalPkgs = true;"
        echo "            home-manager.useUserPackages = true;"
        echo "            home-manager.users.\${homeManagerUser} = homeManagerConfig;"
        echo "            home-manager.extraSpecialArgs = { inherit inputs; };"
        echo "          }"
        echo "        ];"
        echo "      };"
        echo "---------------------------------------------------------------"
        echo ""
        log "If nix-darwin is not yet installed, run:"
        log "  nix run nix-darwin -- switch --flake .#$hostname"
        log ""
        log "After that, use: darwin-rebuild switch --flake .#$hostname"
    fi

else
    err "Invalid option."
    exit 1
fi
