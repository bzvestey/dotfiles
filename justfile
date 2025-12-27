# This of commands that can be run, and a way to keep track of the commands
# I want to use on a regular basis

###############################################################################
## Updating the device                                                       ##
###############################################################################

alias ncu := nixos-channel-update
alias ns := nixos-switch
alias hms := home-manager-switch

# Updates the nixos channels and switches to the latest of everything
update: nixos-channel-update nixos-switch home-manager-switch

# Clean up old generations
cleanup:
    sudo nix-collect-garbage -d

# Pull the latest channels and see what would change with a build
nixos-channel-update:
    sudo nixos-rebuild dry-build --upgrade-all

# Switches over to the latest nixos config using the current version of the
# channels the system is looking at
nixos-switch:
    sudo nixos-rebuild switch

# Switches over to the latest home-manager config using the current version of
# the channels the system is looking at
home-manager-switch:
    home-manager switch -b backup

###############################################################################
## Setting up a device                                                       ##
###############################################################################
