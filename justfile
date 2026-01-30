# Update flake inputs
update:
    nix flake update

# Switch to the current system configuration
switch host=`hostname`:
    sudo nixos-rebuild switch --flake .#{{host}}

# Setup as new boost config for the current system configuration
boot host=`hostname`:
    sudo nixos-rebuild boot --flake .#{{host}}

# Update system firmware
firmware:
    fwupdmgr refresh
    fwupdmgr get-updates
    fwupdmgr update

# Clean up old generations and optimise the store
clean:
    sudo nix-collect-garbage -d
    nix-store --optimise
