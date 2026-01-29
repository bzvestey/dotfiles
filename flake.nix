{
  description = "Setups and environment for working on my nix configs.";

  inputs = {
    # Pin nixpkgs version
    nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/a1bab9e494f5f4939442a57a58d0449a109593fe.tar.gz";
  };

  outputs = ( self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
	config.allowUnfree = true;
      };
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
	  kilocode-cli
	];

	shellHook = ''
          echo "Welcome to your Nix development environment for working on your nix configs!"
	'';
      };
    };
}
