{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.bzvestey = {
    isNormalUser = true;
    description = "Bryan Vestey";
    extraGroups = [ "networkmanager" "wheel" "users" "bzvestey" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    # thunderbird
    ];
  };
}
