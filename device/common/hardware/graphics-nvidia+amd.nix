{ config, lib, pkgs, ... }:

{
  # Nvidia graphics configuration information: https://nixos.wiki/wiki/Nvidia
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Note: check https://github.com/NixOS/nixos-hardware/blob/master/framework/16-inch/amd-ai-300-series/nvidia/default.nix for better settings at some point

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true;

    # Hybrid graphics with PRIME offload for better battery life
    # AMD iGPU by default, NVIDIA dGPU on demand via nvidia-offload command
    prime = {
      # WARNING: These defaults may not match your system!
      # Bus IDs vary depending on installed expansion cards and NVMe drives.
      # You MUST override these values - see README.md for instructions.
      # Bus IDs can be found with `lspci | grep -E "VGA|3D|Display"`
      amdgpuBusId = "PCI:194:0:0";
      nvidiaBusId = "PCI:193:0:0";
    };

    # Power management for hybrid graphics
    powerManagement.enable = lib.mkDefault true;
  };

  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];
}
