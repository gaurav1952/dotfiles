
{config,  pkgs, ...}:
{
 home.username = "g4ur4v";
 home.homeDirectory = "/home/g4ur4v";
 home.stateVersion = "26.05";

 programs.home-manager.enable = true;

 imports = [
	./home/fish.nix
	./home/packages.nix
	./home/kitty.nix
	./home/nvim.nix
	./home/direnv.nix

 ];
}
