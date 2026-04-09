{
  config,
  pkgs,
  lib,
  ...
}:

{
  config.users.defaultUserShell = pkgs.zsh;
}