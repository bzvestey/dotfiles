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

    localpkgs = {
      url = "github:bzvestey/dotfiles?dir=packages";
      inputs.nixpkgs.follows = "nixpkgs";
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
      localpkgs,
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
          { nixpkgs.overlays = [ localpkgs.overlays.default ]; }
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

      nixosConfigurations.framework13nix = nixpkgs.lib.nixosSystem {
        system = linuxSystem;
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = [ localpkgs.overlays.default ]; }
          ./hosts/framework13nix/default.nix
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${homeManagerUser} = homeManagerConfig;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

      # nix-darwin Configurations (macOS)
      darwinConfigurations.minastas-ai-mini = nix-darwin.lib.darwinSystem {
        system = darwinSystem;
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = [ localpkgs.overlays.default nix-darwin.overlays.default ]; }
          ./hosts/darwin-minastas-ai-mini/default.nix
          agenix.nixosModules.default
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.${homeManagerUser} = homeManagerConfig;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

      # Expose the darwin configuration for standalone use
      darwinPackages.${darwinSystem} = self.darwinConfigurations.minastas-ai-mini.pkgs;

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
            # Nix tools
            nil
            nixfmt-rfc-style
            statix
            deadnix
            agenix.packages.${linuxSystem}.default

            # Development tools
            zellij

            # AI tools
            opencode
            claude-code
            gemini-cli
          ];
          shellHook = ''
            echo "Welcome to your Nix development environment!"
            # zellij -l ./development.kdl
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
            # Nix tools
            nil
            nixfmt-rfc-style
            statix
            deadnix

            # Development tools
            zellij

            # AI tools
            opencode
            claude-code
          ];
          shellHook = ''
            echo "Welcome to your macOS Nix development environment!"
            zellij -l ./development.kdl
          '';
        };
    };
}
