{ config, pkgs, ... }:

{
  # Enable bluetooth reader
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
      Policy = {
        AuthEnable = true;
      };
    };
  };
}
