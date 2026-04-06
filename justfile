# Update flake inputs
update:
    nix flake update
    just sync-backgrounds

# Sync backgrounds from samba share
sync-backgrounds:
    #!/usr/bin/env bash
    if mountpoint -q ~/storage && [ -d ~/storage/photos/backgrounds ]; then
        echo "Syncing backgrounds..."
        mkdir -p ~/Pictures/backgrounds
        rsync -av --update ~/storage/photos/backgrounds/ ~/Pictures/backgrounds/
    else
        echo "Samba share ~/storage not connected or backgrounds folder not found, skipping background sync."
    fi

# Switch to the current system configuration
switch host=`hostname`:
    sudo nixos-rebuild switch --flake .#{{host}}

# Setup as new boost config for the current system configuration
boot host=`hostname`:
    sudo nixos-rebuild boot --flake .#{{host}}

# Update system firmware
firmware:
    fwupdmgr refresh --force
    fwupdmgr get-updates
    fwupdmgr update

# Clean up old generations and optimise the store
clean:
    sudo nix-collect-garbage -d
    nix-store --optimise
