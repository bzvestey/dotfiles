{ config, ... }:

{
  system.primaryUser = config.myConfig.user.name;
  environment.systemPath = [
    "/opt/homebrew/bin"
  ];
  environment.pathsToLink = [
    "/Applications"
  ];
}
