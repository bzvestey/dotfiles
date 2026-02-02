{ config, pkgs, ... }:

{
  # TUI based file manager
  programs.yazi.enable = true;

  environment.systemPackages = with pkgs; [
    # Files
    zip
    unzip
    rsync
    ffmpeg
    imagemagick
    (yazi.override { _7zz = _7zz-rar; })
  ];
}
