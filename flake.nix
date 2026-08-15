
{
  description = "grv-dots config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@ inputs: {
    nixosConfigurations.grv = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
      ./configuration.nix
	 home-manager.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; }; #If you want access to inputs in your home.nix
              users.g4ur4v = ./home.nix; # replace <USERNAME> with your actual username
            };
          }
      ];
    };
  };
}
