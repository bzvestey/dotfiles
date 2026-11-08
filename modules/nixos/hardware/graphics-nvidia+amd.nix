{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Nvidia graphics configuration information: https://nixos.wiki/wiki/Nvidia
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Note: check https://github.com/NixOS/nixos-hardware/blob/master/framework/16-inch/amd-ai-300-series/nvidia/default.nix for better settings at some point

  hardware.nvidia = {
    # The RTX 5070 (Blackwell) requires NVIDIA's open kernel modules.
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    modesetting.enable = true;
    nvidiaSettings = true;

    # Preserve PRIME sync rather than on-demand render offloading.
    prime = {
      sync.enable = true;
      offload.enable = false;
      # WARNING: These defaults may not match your system!
      # Bus IDs vary depending on installed expansion cards and NVMe drives.
      # You MUST override these values - see README.md for instructions.
      # Bus IDs can be found with `lspci | grep -E "VGA|3D|Display"`
      amdgpuBusId = "PCI:194:0:0";
      nvidiaBusId = "PCI:193:0:0";
    };

    # Power management for hybrid graphics
    powerManagement.enable = lib.mkDefault true;
    powerManagement.finegrained = false;
  };

  services.xserver.videoDrivers = [
    "nvidia"
  ];
}
