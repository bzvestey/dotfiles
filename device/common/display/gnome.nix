{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    # Gnome Extensions
    gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.dash-to-dock
    gnomeExtensions.search-light
    gnomeExtensions.system-monitor
    gnomeExtensions.tailscale-qs
    gnomeExtensions.wallpaper-slideshow
  ];
}
