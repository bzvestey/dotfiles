{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Import community hardware settings
    "${inputs.nixos-hardware}/framework/16-inch/amd-ai-300-series"
    "${inputs.nixos-hardware}/framework/16-inch/amd-ai-300-series/nvidia"

    # Include the results of the hardware scan.
    ./hardware.nix

    # Import core nix modules
    ../../modules/nix/core/base.nix
    ../../modules/nix/core/time.nix
    ../../modules/nix/core/secrets.nix
    ../../modules/nix/core/users.nix

    # Import core nixos modules
    ../../modules/nixos/core/base.nix
    ../../modules/nixos/core/locale.nix
    ../../modules/nixos/core/networking.nix
    ../../modules/nixos/core/users.nix

    # Include hardware nixos configurations
    ../../modules/nixos/hardware/audio.nix
    ../../modules/nixos/hardware/fingerprint-reader.nix
    ../../modules/nixos/hardware/graphics-nvidia+amd.nix
    ../../modules/nixos/hardware/keyboard.nix
    ../../modules/nixos/hardware/printer.nix

    # Include display manager configurations
    ../../modules/nixos/display/gnome.nix
    ../../modules/nixos/display/hyprland.nix

    # Include services configurations
    ../../modules/nixos/services/tailscale.nix
    ../../modules/nixos/services/syncthing.nix
    ../../modules/nixos/services/flatpak.nix
    ../../modules/nixos/services/samba.nix

    # Include nix program configurations
    ../../modules/nix/programs/1password.nix
    ../../modules/nix/programs/3dprinting.nix
    ../../modules/nix/programs/browsers.nix
    ../../modules/nix/programs/core.nix
    ../../modules/nix/programs/files.nix
    ../../modules/nix/programs/programming.nix
    ../../modules/nix/programs/terminal.nix

    # Include program configurations
    ../../modules/nixos/programs/1password.nix
    ../../modules/nixos/programs/3dprinting.nix
    ../../modules/nixos/programs/browsers.nix
    ../../modules/nixos/programs/core.nix
    ../../modules/nixos/programs/files.nix
    ../../modules/nixos/programs/programming.nix
    ../../modules/nixos/programs/terminal.nix
  ];

  boot.initrd.luks.devices."luks-f8c54aa1-9fa7-41ca-bc09-cacb852ad36b".device =
    "/dev/disk/by-uuid/f8c54aa1-9fa7-41ca-bc09-cacb852ad36b";
  networking.hostName = "framework_16_nix";

  environment.systemPackages = [
    pkgs.localpkgs.hakuneko-nightly
  ];

  system.stateVersion = "25.05";
}
