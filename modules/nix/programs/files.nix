{ config, pkgs, ... }:

{
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
