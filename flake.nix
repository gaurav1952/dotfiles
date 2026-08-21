
{
  description = "grv-dots config";

  # nixConfig = {
  #   extra-substituters = [ "https://vicinae.cachix.org" ];
  #   extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
  # };

      inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
        home-manager = {
          url = "github:nix-community/home-manager/release-26.05";
          inputs.nixpkgs.follows = "nixpkgs";
        };
        zen-browser = {
              url = "github:youwen5/zen-browser-flake";
              inputs.nixpkgs.follows = "nixpkgs";
        };
        helium = {
              url = "github:AlvaroParker/helium-nix";
              inputs.nixpkgs.follows = "nixpkgs";
            };
        # vicinae.url = "github:vicinaehq/vicinae";
      };

      outputs = { self, nixpkgs, home-manager, ... }@ inputs: {
# ---------------------------------
#  Nixos Configurations
#  --------------------------------
        nixosConfigurations.grv = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
          ./configuration.nix
          ];
        };
# ---------------------------------
#  home-manager
#  --------------------------------
      homeConfigurations.grv = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
            };
          extraSpecialArgs = {inherit inputs; };
          modules = [
            ./home.nix
          ];
        };

    };

}
