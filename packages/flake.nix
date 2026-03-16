{
  description = "Local custom packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Build the package set for a given system
      packagesFor =
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          hakuneko-nightly = pkgs.callPackage ./hakuneko-nightly/package.nix { };
        };
    in
    {
      packages = forAllSystems packagesFor;

      overlays.default = final: prev: {
        localpkgs = {
          hakuneko-nightly = final.callPackage ./hakuneko-nightly/package.nix { };
        };
      };
    };
}
