{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

let
  # Pinning to a specific Nixpkgs commit (e.g., 23.11)
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/a1bab9e494f5f4939442a57a58d0449a109593fe.tar.gz") {};
in
pkgs.mkShell {
  # 1. Build Inputs (Libraries and Tools)
  buildInputs = with pkgs; [
    kilocode-cli
  ];

  # 2. Environment Variables
  shellHook = ''
    export EDITOR=nvim
    echo "Welcome to your Nix development environment for working on your nix configs!"
    kilocode --workspace .
  '';
}
