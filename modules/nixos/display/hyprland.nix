{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };

  environment.systemPackages = with pkgs; [
    # Hyprland utils
    waybar
    wofi
    hyprpaper
    nautilus
  ];
}
