{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Import core modules
    ../../modules/nixos/core/locale.nix
    ../../modules/nixos/core/secrets.nix
    ../../modules/nixos/core/time.nix
    ../../modules/nixos/core/users.nix

    # Include services configurations
    ../../modules/nixos/services/tailscale.nix
    ../../modules/nixos/services/syncthing.nix

    # Include program configurations
    ../../modules/nixos/programs/1password.nix
    ../../modules/nixos/programs/3dprinting.nix
    ../../modules/nixos/programs/browsers.nix
    ../../modules/nixos/programs/core.nix
    ../../modules/nixos/programs/files.nix
    ../../modules/nixos/programs/programming.nix
    ../../modules/nixos/programs/terminal.nix
  ];

  # Nix settings
  nix.settings.experimental-features = "nix-command flakes";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
