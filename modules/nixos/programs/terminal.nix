{ config, pkgs, lib, ... }:

{
  # Set up tmux
  programs.tmux.clock24 = true;

  environment.systemPackages =
    with pkgs;
    [
      # Terminal
      ghostty
      systemctl-tui
    ];
}
