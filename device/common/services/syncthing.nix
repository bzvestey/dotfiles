{ config, pkgs, ... }:

let
  vars = import ./vars.nix;
in
{
  # Setup syncthing
  services.syncthing = {
    enable = true;
    group = "users";
    user = "bzvestey";
    dataDir = "/home/bzvestey/Documents";
    configDir = "/home/bzvestey/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "truenas" = { id = vars.syncthing_remote_id; };
      };
      folders = {
        "yv9ej-sr6dr" = {
          label = "proton";
          path = "/home/bzvestey/proton";
          devices = [ "truenas" ];
        };
        "6bvaa-syglg" = {
          label = "manga";
          path = "/home/bzvestey/Documents/Manga";
          devices = [ "truenas" ];
        };
      };
      gui = {
        enabled = true;
        tls = false;
        sendBasicAuthPrompt = false;
        address = "127.0.0.1:8384";
        theme = "dark";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
