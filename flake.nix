{
  description = "Bryan's NixOS and macOS Configuration";

  inputs = {
    # Standard NixOS unstable branch
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-darwin,
      home-manager,
      nix-darwin,
      agenix,
      ...
    }@inputs:
    let
      linuxSystem = "x86_64-linux";
      darwinSystem = "aarch64-darwin";

      # Common home manager configuration
      homeManagerUser = "bzvestey";
      homeManagerConfig = import ./modules/home/home.nix;
    in
    {
      # NixOS Configurations (Linux)
      nixosConfigurations.framework16nix = nixpkgs.lib.nixosSystem {
        system = linuxSystem;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/framework16nix/default.nix

          # Agenix
          agenix.nixosModules.default

          # Import the Home Manager NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.${homeManagerUser} = homeManagerConfig;
          }
        ];
      };

      # nix-darwin Configurations (macOS)
      darwinConfigurations.macbook = nix-darwin.lib.darwinSystem {
        system = darwinSystem;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/darwin-macbook/default.nix

          # Home Manager for Darwin
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.${homeManagerUser} = homeManagerConfig;
          }
        ];
      };

      # Expose the darwin configuration for standalone use
      darwinPackages.${darwinSystem} = self.darwinConfigurations.macbook.pkgs;

      # Formatters
      formatter.${linuxSystem} = nixpkgs.legacyPackages.${linuxSystem}.nixfmt-rfc-style;
      formatter.${darwinSystem} = nixpkgs-darwin.legacyPackages.${darwinSystem}.nixfmt-rfc-style;

      # Development Shells
      devShells.${linuxSystem}.default =
        let
          pkgs = import nixpkgs {
            system = linuxSystem;
            config.allowUnfree = true;
          };
        in
        pkgs.mkShell {
          buildInputs = with pkgs; [
            nil
            nixfmt-rfc-style
            statix
            deadnix
            git
            opencode
            agenix.packages.${linuxSystem}.default
          ];
          shellHook = ''
            echo "Welcome to your Nix development environment!"
            # opencode
          '';
        };

      devShells.${darwinSystem}.default =
        let
          pkgs = import nixpkgs-darwin {
            system = darwinSystem;
            config.allowUnfree = true;
          };
        in
        pkgs.mkShell {
          buildInputs = with pkgs; [
            nil
            nixfmt-rfc-style
            statix
            deadnix
            git
            opencode
          ];
          shellHook = ''
            echo "Welcome to your macOS Nix development environment!"
          '';
        };
    };
}
