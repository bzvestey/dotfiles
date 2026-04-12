{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Install direnv
  programs.direnv.enable = true;

  # Set up our favorite shell, zsh
  programs.zsh.enable = true;

  # Set up tmux
  programs.tmux = {
    enable = true;
  };
}
