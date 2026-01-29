{ config, pkgs, ... }:

{
  # Install neovim for editing files
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Update firmware for laptop
  services.fwupd.enable = true;

  environment.systemPackages = with pkgs; [
    # Version control needed to pull down configs
    git
    jujutsu

    # Running commands
    just
  ];
}
