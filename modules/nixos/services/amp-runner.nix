{
  config,
  pkgs,
  lib,
  ...
}:

let
  userHome = config.myConfig.user.home;
  userName = config.myConfig.user.name;
in
{
  # Start the user's systemd instance at boot instead of at first login, so
  # the runner is available as soon as the machine is up.
  users.users.${userName}.linger = true;

  home-manager.users.${userName}.systemd.user.services.amp-runner = {
    Unit = {
      Description = "Amp runner serving ${userHome}/dev";
    };

    Service = {
      WorkingDirectory = "${userHome}/dev";
      ExecStart = "${lib.getExe pkgs.llm-agents.amp} --no-tui --runner-id ${config.networking.hostName} --remote-control-terminal --amp-env --share-network --remote-control-portals --discover-dirs";
      # systemd user services get a minimal PATH; give threads the same tools as a login shell.
      Environment = [
        "PATH=/run/wrappers/bin:/etc/profiles/per-user/${userName}/bin:${userHome}/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
      ];
      # Keep retrying while the network comes up at boot or after a crash.
      Restart = "always";
      RestartSec = 10;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
