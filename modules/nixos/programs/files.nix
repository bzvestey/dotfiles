{ config, pkgs, ... }:

{
  # TUI based file manager
  programs.yazi.enable = true;

  environment.systemPackages = with pkgs; [
    # Files
    rsync
    ffmpeg
    imagemagick
    (yazi.override { _7zz = _7zz-rar; })
  ];
}
