{ config, pkgs, ... }:

{
  # Enable tailscale
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
}
