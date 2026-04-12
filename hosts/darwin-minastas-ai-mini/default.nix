{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # You can use https://github.com/bgub/nix-macos-starter/tree/main as a good base for changes here

  imports = [
    # Import core nix modules
    ../../modules/nix/core/base.nix
    ../../modules/nix/core/time.nix
    ../../modules/nix/core/users.nix
    ../../modules/nix/core/secrets.nix

    # Import core nix-darwin modules
    ../../modules/nix-darwin/core/settings.nix
    ../../modules/nix-darwin/core/users.nix

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

    # Include darwin homebrew configurations
    ../../modules/nix-darwin/homebrew/core.nix
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
