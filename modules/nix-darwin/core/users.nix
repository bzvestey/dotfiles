{ config, primaryUser, ... }:

{
  system.primaryUser = config.myConfig.user.name;
  users.users.${primaryUser}.environment.systemPath = [
    "/opt/homebrew/bin"
  ];
  users.users.${primaryUser}.environment.pathsToLink = [
    "/Applications"
  ];
}
