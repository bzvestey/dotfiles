{ config, pkgs, inputs, ... }:

{

  imports = [
    # Import core nix modules
    ../../modules/nix/core/base.nix
    ../../modules/nix/core/time.nix
    ../../modules/nix/core/users.nix
    ../../modules/nix/core/secrets.nix

    # Include services configurations
    # ../../modules/nix/services/tailscale.nix
    # ../../modules/nix/services/syncthing.nix

    # Include nix program configurations
    ../../modules/nix/programs/1password.nix
    ../../modules/nix/programs/3dprinting.nix
    ../../modules/nix/programs/browsers.nix
    ../../modules/nix/programs/core.nix
    ../../modules/nix/programs/files.nix
    ../../modules/nix/programs/programming.nix
    ../../modules/nix/programs/terminal.nix
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    just-lsp
    git
    jujutsu
    just
    darwin-rebuild
  ];

  users.users.bzvestey.home = /Users/bzvestey;
  
  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
