{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Slicers
    orca-slicer
    prusa-slicer
  ];
}
