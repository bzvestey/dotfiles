{ config, pkgs, nix-homebrew, homebrew-core, homebrew-cask, ... }:

{
  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;

    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    enableRosetta = true;

    # User owning the Homebrew prefix
    user = config.myConfig.user.name;

    # Automatically migrate existing Homebrew installations
    autoMigrate = true;

    # Declarative tap management
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
    };

    # Enable fully-declarative tap management.
    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
    mutableTaps = false;
  };

  homebrew = {
    enable = true;
    enableZshIntegration = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
    brews = [
      "microsoft-teams"
      "visual-studio-code"
      "node@24"
    ]
  };
}
