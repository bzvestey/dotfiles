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

    displayName = lib.mkOption {
      type = lib.types.str;
      default = "Bryan Vestey";
      description = "The display name for the primary user";
    };

    email = lib.mkOption {
      type = lib.types.str;
      default = "bryan@vestey.dev";
      description = "The email for the primary user";
    };
  };

  config = {
    # Define a user account. Don't forget to set a password with 'passwd'.
    users.users.${cfg.name} = {
      description = cfg.displayName;
      home = cfg.home;
      shell = pkgs.zsh;
      # packages = with pkgs; [
      #   # thunderbird
      # ];
    };
  };
}
