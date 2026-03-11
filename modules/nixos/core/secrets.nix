{ config, pkgs, ... }:

let
  userHome = config.myConfig.user.home;
in
{
  # Path to the SSH key used to decrypt secrets
  age.identityPaths = [ "${userHome}/.ssh/id_ed25519" ];
}
