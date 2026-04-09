{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.localBinInPath = true;

  # AppImage
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.appimage.package = pkgs.appimage-run.override {
    extraPkgs = pkgs: [
      pkgs.icu
      pkgs.libxcrypt-legacy
      pkgs.ffmpeg
      pkgs.imagemagick
      pkgs.webkitgtk_4_1
    ];
  };
}
