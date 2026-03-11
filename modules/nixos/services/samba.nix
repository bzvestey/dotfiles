{ config, pkgs, ... }:

let
  userHome = config.myConfig.user.home;
in
{
  # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."${userHome}/storage" = {
    device = "//nas.tailbc181.ts.net/Computer";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [ "${automount_opts},credentials=${userHome}/dev/dotfiles/smb-secrets,uid=1000,gid=1000" ];
  };

  networking.firewall.extraCommands = "iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns";
}
