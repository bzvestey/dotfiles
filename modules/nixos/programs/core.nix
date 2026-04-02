{ config, pkgs, lib, ... }:

{
  # Install neovim for editing files
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Update firmware for laptop (Linux-only)
  services.fwupd.enable = lib.mkIf (!pkgs.stdenv.isDarwin) true;

  environment.systemPackages =
    with pkgs;
    [
      # Version control needed to pull down configs
      git
      jujutsu

      # Nix language servers
      nixd
      nil

      # Running commands
      just

      # EPub/lcpl reader
      thorium-reader
    ]
    ++ lib.optionals (!pkgs.stdenv.isDarwin) [
      # Utilites for working with devices
      pciutils
      usbutils
    ];
}
