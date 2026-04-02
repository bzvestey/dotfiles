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
