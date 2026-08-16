{ config, pkgs, ... }:

let
  userHome = config.myConfig.user.home;
in
{
  age.identityPaths =
    if pkgs.stdenv.hostPlatform.isDarwin then
      [ "${userHome}/.ssh/id_ed25519" ]
    else
      [ "/etc/ssh/ssh_host_ed25519_key" ];
}
