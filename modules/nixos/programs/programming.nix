# All the software needed when working with code that is not part of the base packages that are needed

{ ... }:

{
  # Enable common container config files in /etc/containers (Linux-only)
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  programs.nix-ld.enable = true;
}
