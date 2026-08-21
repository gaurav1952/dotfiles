{ pkgs,inputs, ...}:
{
	home.packages = with pkgs; [
	  neovim
	  btop
	  yazi
    fastfetch
    onlyoffice-desktopeditors
    zoom-us
    zed-editor
    snapshot
    obs-studio
    kdePackages.kdenlive
    brave
    gimp
    pkgs.wl-clipboard
    pkgs.vivaldi
    pkgs.ghostty
    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
	];
}
