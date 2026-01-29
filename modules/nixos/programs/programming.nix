# All the software needed when working with code that is not part of the base packages that are needed

{ config, pkgs, ... }:

{
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Language
    uv
    go
    rustup
    clang
    gcc
    llvm

    # Editors
    zed-editor

    # Dev tools
    kubectl
    jq
    k9s

    # Podman and containers
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    podman-compose # start group of containers for dev
  ];
}
