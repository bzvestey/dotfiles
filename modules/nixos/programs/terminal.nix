{ config, pkgs, lib, ... }:

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

  environment.systemPackages =
    with pkgs;
    [
      # Terminal
      ghostty
    ]
    ++ lib.optionals (!pkgs.stdenv.isDarwin) [
      # System (Linux-only)
      systemctl-tui
    ];
}
