{
  config,
  pkgs,
  lib,
  ...
}:

{
  config.users.defaultUserShell = pkgs.zsh;

  # Set user fields that are not available in nix-darwin
  config.users.users.bzvestey.isNormalUser = true;
  config.users.users.bzvestey.extraGroups = [
    "networkmanager"
    "wheel"
    "users"
    "bzvestey"
    "dialout"
  ];
}