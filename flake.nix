{
  description = "Nel's NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Home-manager setup
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Colors
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = inputs@{ nixpkgs, home-manager, nix-colors, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
	  ./driver

	  home-manager.nixosModules.home-manager
	  {
            home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.lauda = import ./home/home.nix;
	    home-manager.extraSpecialArgs = { inherit nix-colors; };
	  }
        ];
      };
    };
  };
}
