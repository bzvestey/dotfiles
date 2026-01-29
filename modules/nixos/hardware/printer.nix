{ config, pkgs, ... }:

{
  # Enable CUPS to print documents.
  services.printing.enable = true;
  hardware.printers = {
    ensurePrinters = [
      # {
      #   name = "Samsung-C43x";
      #   location = "Home";
      #   deviceUri = "ipp://10.15.7.75/ipp/print";
      #   model = "everywhere";
      # }
    ];
  };
}
