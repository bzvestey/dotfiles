# Dem Dot Files
These are the random dot or settings files I use on \*nix based devices.  Some
might be OS specific, or only when I decide to use specific programs (bash/zsh).

## MacOS

### Basics
* Clone this to ~/dev/dotfiles
* symlink it to ~/.mydotfiles

### zsh
* Download zsh
* Download [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* Start zsh at least once (oh-my-zsh should do this for you)
* Update ~/.zshrc to look something like this:
```sh
# Path to my oh-my-zsh installation.
export ZSH=/home/bzvestey/.oh-my-zsh

# Path to my .zshrc file
source ~/.mydotfiles/zsh/zshrc-macos.zsh
```

## NixOS info

1. Figure out the deivce name you want and set it as an environment variable in your terminal, this way it can be referenced in the other scripts

    ```sh
    export device_name="<name of device>"
    ```

### New device setup

1. Create a folder for the device, and copy the generated configs into it

    ```sh
    mkdir -p $HOME/dev/dotfiles/devices/$device_name
    cp /etc/nixos/hardware-configuration.nix $HOME/dev/dotfiles/devices/$device_name/
    cp /etc/nixos/configuration.nix $HOME/dev/dotfiles/devices/$device_name/configuration.nix.base
    ```

1. Createa a new configuration for the device using the common configs.

    ```sh
    cat <<EOF > $HOME/dev/dotfiles/devices/$device_name/configuration.nix
    { config, pkgs, ... }:

    {
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        
        # Include core configurations
        ../common/core/base.nix
        ../common/core/locale.nix
        ../common/core/networking.nix
        ../common/core/time.nix
        ../common/core/users.nix

        # Include hardware configurations
        ../common/hardware/audio.nix
        ../common/hardware/fingerprint-reader.nix
        ../common/hardware/keyboard.nix
        ../common/hardware/printer.nix

        # Include display manager configurations
        ../common/display/gnome.nix

        # Include services configurations
        ../common/services/tailscale.nix
        # ../common/services/syncthing.nix
        ../common/services/flatpak.nix

        # Include program configurations
        ../common/programs/1password.nix
        ../common/programs/browsers.nix
        ../common/programs/files.nix
        ../common/programs/programming.nix
        ../common/programs/terminal.nix
        ];

    # Fill in "boot.initrd.luks.devices" line from /etc/nixos/configuration.nix
    # boot.initrd.luks.devices....;

    networking.hostName = "$device_name"; # Define your hostname.

    # Set the "system.stateVersion" line from /etc/nixos/configuration.nix
    # system.stateVersion = "...";
    }
    EOF
    ```

1. Update the new `configuration.nix` file with local customizations
1. Continue to the steps for all devices

### Setup steps for all devices

1. Setup the nixos configs

    ```sh
    sudo rm -rf /etc/nixos/*
    sudo ln -s $HOME/dev/dotfiles/devices/$device_name /etc/nixos
    cp $HOME/dev/dotfiles/devices/common/services/vars.nix.example $HOME/dev/dotfiles/devices/common/services/vars.nix
    ```

1. Set the variables in `$HOME/dev/dotfiles/devices/common/services/vars.nix` before continuing on.
1. Setup the home-manager configs

    ```sh
    mkdir ~/.config/home-manager
    ln -s $HOME/dev/dotfiles/config/home-manager $HOME/.comfig/home-manager
    ```

1. Move to unstable channel and add home-manager channel

    ```sh
    sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
    sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    ```

1. Install nixos packages based on updated channels

    ```sh
    sudo nix-channel --update
    sudo nixos-rebuild switch --upgrade
    ```

1. Install home-manager

    ```sh
    nix-shell '<home-manager>' -A install
    ```

1. Setup Tailscale

    ```sh
    sudo tailscale set --operator=$USER
    tailscale up
    ```

1. Setup the fingerprint reader

    ```sh
    fprintd-enroll -f right-index-finger
    fprintd-enroll -f left-index-finger
    ```

## Links

- https://nixos.wiki/wiki/Tailscale
- https://nixos.wiki/wiki/Zsh
- https://nixos.wiki/wiki/Neovim
- https://nixos.wiki/wiki/Syncthing
- https://nixos.wiki/wiki/Visual_Studio_Code
- https://nixos.wiki/wiki/1Password
- https://nixos.wiki/wiki/GNOME
- https://nixos.wiki/wiki/Command_Shell
- https://nixos.wiki/wiki/Home_Manager
- https://nixos.wiki/wiki/Tmux
- https://wiki.nixos.org/wiki/Atuin
- https://nixos.wiki/wiki/Flatpak
- https://nixos.wiki/wiki/Podman
- https://nixos.wiki/wiki/Printing
- https://nixos.wiki/wiki/Python
- https://nixos.wiki/wiki/Rust
- https://wiki.nixos.org/wiki/Yazi

- https://wiki.nixos.org/wiki/AMD_GPU
- https://nixos.wiki/wiki/AMD_GPU
- https://wiki.nixos.org/wiki/NVIDIA
- https://nixos.wiki/wiki/Nvidia
- https://wiki.nixos.org/wiki/CUDA
