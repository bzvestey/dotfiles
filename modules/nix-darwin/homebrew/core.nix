{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;
    enableZshIntegration = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
    brews = [
      "node@24"
    ];
    casks = [
      "microsoft-teams"
    ];
  };
}
