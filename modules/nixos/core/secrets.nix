{ config, pkgs, ... }:

{
  # Path to the SSH key used to decrypt secrets
  age.identityPaths = [ "/home/bzvestey/.ssh/id_ed25519" ];
}
