{ pkgs,inputs, ...}:
{
	home.packages = with pkgs; [
	  kitty
	  neovim
	  ripgrep
	  fd
	  jq
	  tree
	  btop
	  yazi
	];
}
