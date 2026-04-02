{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Import community hardware settings
    "${inputs.nixos-hardware}/framework/13-inch/11th-gen-intel"

    # Include the results of the hardware scan.
    ./hardware.nix

    # Import core modules
    ../../modules/nixos-linux/core/base.nix
    ../../modules/nixos/core/locale.nix
    ../../modules/nixos-linux/core/networking.nix
    ../../modules/nixos/core/secrets.nix
    ../../modules/nixos/core/time.nix
    ../../modules/nixos/core/users.nix

    # Include hardware configurations
    ../../modules/nixos-linux/hardware/audio.nix
    ../../modules/nixos-linux/hardware/bluetooth.nix
    ../../modules/nixos-linux/hardware/fingerprint-reader.nix
    ../../modules/nixos-linux/hardware/keyboard.nix
    ../../modules/nixos-linux/hardware/printer.nix

    # Include display manager configurations
    # ../../modules/nixos-linux/display/gnome.nix
    # ../../modules/nixos-linux/display/hyprland.nix
    ../../modules/nixos-linux/display/plasma.nix

    # Include services configurations
    ../../modules/nixos/services/tailscale.nix
    ../../modules/nixos/services/syncthing.nix
    ../../modules/nixos-linux/services/flatpak.nix
    ../../modules/nixos-linux/services/samba.nix

    # Include program configurations
    ../../modules/nixos/programs/1password.nix
    ../../modules/nixos/programs/3dprinting.nix
    ../../modules/nixos/programs/browsers.nix
    ../../modules/nixos/programs/core.nix
    ../../modules/nixos/programs/files.nix
    ../../modules/nixos/programs/programming.nix
    ../../modules/nixos/programs/terminal.nix

  ];

  networking.hostName = "framework13nix";

  environment.systemPackages = [
    pkgs.localpkgs.hakuneko-nightly
  ];

  system.stateVersion = "25.11";
}
