{
  config,
  pkgs,
  ...
}:

{
  config.users.defaultUserShell = pkgs.zsh;

  # Set user fields that are not available in nix-darwin
  config.users.users.${config.myConfig.user.name} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "users"
      config.myConfig.user.name
      "dialout"
    ];
  };
}
