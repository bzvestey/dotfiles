{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Openscad
    openscad-unstable # normal releases have not happened since 2021...

    # Slicers
    orca-slicer
    bambu-studio
    prusa-slicer
  ];
}
