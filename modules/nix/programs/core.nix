{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # Version control needed to pull down configs
    git
    jujutsu

    # Editor
    neovim

    # Nix language servers
    nixd
    nil

    # Running commands
    just

    # Utilites for working with devices
    pciutils
    usbutils

    # System utilities
    dust
  ];
}
