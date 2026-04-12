{ pkgs, lib, ... }:

{
  # Install neovim for editing files
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Update firmware for laptop (Linux-only)
  services.fwupd.enable = lib.mkIf (!pkgs.stdenv.isDarwin) true;
}
