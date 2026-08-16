{ pkgs, ...}:

{
  programs.fish = {
	enable = true;

	interactiveShellInit = ''
	set fish_greeting
	'';


	shellAliases = {
	  cls = "clear";
	  cd  = "z";
	  v   = "nvim";
	  gpp = "c++";
	  cpy = "wl-copy";


	  #eza
      l   = "eza -al --color=always --group-directories-first --icons";
     la   = "eza -a --color=always --group-directories-first --icons";
     ll   = "eza -l --color=always --group-directories-first --icons";
     lt   = "eza -aT --color=always --group-directories-first --icons";
    "l."  = "eza -a | grep -e '^\\.'";


   #NixOs
   nixbuild  = "sudo nixos-rebuild build --flake ~/grv-dots#grv";
   nixswitch = "sudo nixos-rebuild switch --flake ~/grv-dots#grv";
	};

	functions = {
	  mkcd = ''
	    mkdir -p $argv[1]
	    and cd $argv[1]
	    '';
	  y = ''
            set tmp (mktemp -t "yazi-cwd.XXXXXX")
            command yazi $argv --cwd-file="$tmp"
              if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
            builtin cd -- "$cwd"
              end
             rm -f -- "$tmp"
             '';

           };
  };

  programs.starship = {
	enable = true;
	enableFishIntegration = true;
  };
  xdg.configFile."starship.toml".source = ../config/starship/starship.toml;


  programs.zoxide = {
  	enable = true;
  	enableFishIntegration = true;
  };
  programs.eza = {
  	enable = true;
  	enableFishIntegration = true;
  	icons = "auto";
  };
}
