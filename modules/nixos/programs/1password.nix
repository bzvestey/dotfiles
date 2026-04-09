{ config, pkgs, lib, ... }:

{
  # Install 1password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = lib.mkIf (!pkgs.stdenv.isDarwin) [ "bzvestey" ];
  };

  environment.etc."1password/custom_allowed_browsers".mode = "0755";
}
