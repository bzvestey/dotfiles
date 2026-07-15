{
  inputs,
  lib,
  pkgs,
  ...
}:

let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in
{
  # Import unconditionally (conditioning `imports` on `pkgs` causes infinite
  # recursion). home.nix is shared with the Darwin host, so the actual config
  # below is gated on Linux where Plasma exists.
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  programs.plasma = lib.mkIf isLinux {
    enable = true;

    workspace = {
      clickItemTo = "select";
      lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "BreezeDark";
    };

    kwin = {
      virtualDesktops = {
        rows = 1;
        number = 4;
      };
    };

    # Keep whatever isn't declared here under manual control so the desktop
    # stays usable while this config grows.
    overrideConfig = false;
  };
}
