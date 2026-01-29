{ config, pkgs, ... }:

{
  # Install firefox.
  programs.firefox.enable = true;

  # Setup chrome
  programs.chromium.enable = true;

  environment.systemPackages = with pkgs; [
    google-chrome
  ];
}
