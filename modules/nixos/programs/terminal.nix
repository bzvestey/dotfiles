{ config, pkgs, ... }:

{
  # Install direnv
  programs.direnv.enable = true;

  # Set up our favorite shell, zsh
  programs.zsh.enable = true;

  # Set up tmux
  programs.tmux = {
    enable = true;
    clock24 = true;
  };

  environment.systemPackages = with pkgs; [
    # Terminal
    ghostty

    # System
    systemctl-tui
  ];
}
