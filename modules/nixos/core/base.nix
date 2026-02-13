{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allow using flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Increase the download buffer size to ~500 MiB, so improve update performance
  nix.settings.download-buffer-size = 524288000;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.localBinInPath = true;
}
