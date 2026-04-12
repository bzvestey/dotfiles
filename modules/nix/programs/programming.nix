# All the software needed when working with code that is not part of the base packages that are needed

{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # Language
    uv
    go
    rustup
    clang
    gcc
    llvm

    # Editors
    zed-editor

    # Dev tools
    kubectl
    jq
    k9s
    devenv

    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    podman-compose # start group of containers for dev
  ];

  # Setup devenv caches
  nix.extraOptions = ''
    extra-substituters = https://devenv.cachix.org
    extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
  '';
}
