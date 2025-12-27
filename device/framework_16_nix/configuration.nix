{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      
      # Include core configurations
      ../common/core/base.nix
      ../common/core/locale.nix
      ../common/core/networking.nix
      ../common/core/time.nix
      ../common/core/users.nix

      # Include hardware configurations
      ../common/hardware/audio.nix
      ../common/hardware/fingerprint-reader.nix
      ../common/hardware/graphics-amd.nix
      ../common/hardware/keyboard.nix
      ../common/hardware/printer.nix

      # Include display manager configurations
      ../common/display/gnome.nix

      # Include services configurations
      ../common/services/tailscale.nix
      ../common/services/syncthing.nix
      ../common/services/flatpak.nix

      # Include program configurations
      ../common/programs/1password.nix
      ../common/programs/3dprinting.nix
      ../common/programs/browsers.nix
      ../common/programs/core.nix
      ../common/programs/files.nix
      ../common/programs/programming.nix
      ../common/programs/terminal.nix
    ];

  boot.initrd.luks.devices."luks-f8c54aa1-9fa7-41ca-bc09-cacb852ad36b".device = "/dev/disk/by-uuid/f8c54aa1-9fa7-41ca-bc09-cacb852ad36b";
  networking.hostName = "framework_16_nix";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
