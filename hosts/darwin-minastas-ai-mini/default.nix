{ config, pkgs, inputs, ... }:

{

  imports = [
    # Import core modules
    ../../modules/nix/core/base.nix
    # ../../modules/nixos/core/locale.nix
    # ../../modules/nixos/core/secrets.nix
    ../../modules/nixos/core/time.nix
    # ../../modules/nixos/core/users.nix

    # Include services configurations
    # ../../modules/nixos/services/tailscale.nix
    # ../../modules/nixos/services/syncthing.nix

    # Include program configurations
    # ../../modules/nixos/programs/1password.nix
    # ../../modules/nixos/programs/3dprinting.nix
    # ../../modules/nixos/programs/browsers.nix
    # ../../modules/nixos/programs/core.nix
    # ../../modules/nixos/programs/files.nix
    # ../../modules/nixos/programs/programming.nix
    # ../../modules/nixos/programs/terminal.nix
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

  # Allow using flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  users.users.bzvestey.home = /Users/bzvestey;
  
  # Auto upgrade nix package and the daemon service.
  # ervices.nix-daemon.enable = true;
  
  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
