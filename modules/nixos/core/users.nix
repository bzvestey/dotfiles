{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.myConfig.user;
in
{
  options.myConfig.user = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "bzvestey";
      description = "The username for the primary user account.";
    };

    home = lib.mkOption {
      type = lib.types.str;
      default = if pkgs.stdenv.isDarwin then "/Users/bzvestey" else "/home/bzvestey";
      description = "The home directory for the primary user account.";
    };
  };

  config = lib.mkIf (!pkgs.stdenv.isDarwin) {
    # Define a user account. Don't forget to set a password with 'passwd'.
    # users.defaultUserShell = pkgs.zsh;
    users.users.${cfg.name} = {
      isNormalUser = true;
      description = "Bryan Vestey";
      extraGroups = [
        "networkmanager"
        "wheel"
        "users"
        "bzvestey"
        "dialout"
      ];
      shell = pkgs.zsh;
      packages = with pkgs; [
        # thunderbird
      ];
    };
  };
}
