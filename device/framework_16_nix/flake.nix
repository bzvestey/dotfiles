{
  description = "Bryan's system flake";

  inputs = {
    # Standard NixOS stable branch
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # TODO: See about mixing stable and unstable channels.

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      # This ensures Home Manager uses the same version of nixpkgs as your system
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # 
    nixosConfigurations.framework16nix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; 
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.config.allowUnfree = true; }

        ./configuration.nix # Points to the existing config

        # Import the Home Manager NixOS module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          # Define your user configuration here or in a separate file
          home-manager.users.your-username = import ../../config/home-manager/home.nix;

          # passes variables to home.nix
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}