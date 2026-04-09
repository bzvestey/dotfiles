{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Slicers
    orca-slicer
    bambu-studio
    prusa-slicer
  ];
}
