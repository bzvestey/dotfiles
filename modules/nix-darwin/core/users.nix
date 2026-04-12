{ config, ... }:

{
  system.primaryUser = config.myConfig.user.name;
}
