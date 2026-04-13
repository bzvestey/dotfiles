{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Files
    zip
    unzip
    rsync
    ffmpeg
    imagemagick
  ];
}
