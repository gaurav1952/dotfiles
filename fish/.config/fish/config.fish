set -g fish_greeting
# set -g autopair_tab false
if status is-interactive

    # Commands to run in interactive sessions can go here
    # run neofetch on start
    fastfetch

    #init
    #starship initialize
    starship init fish | source
    #zoxide
    zoxide init fish | source



    #aliases
    #basic aliases
    # alias code='vscodium'
    alias src='source ~/.config/fish/config.fish'
    alias cls='clear'
    alias cd="z"
    alias hx="helix"
    alias v="nvim"
    # alias z="zellij"
    # alias f="thunar . & disown" 
    
    # alias list exa
    alias  l='eza -al --color=always --group-directories-first --icons' # preferred listing
    alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs
    alias ll='eza -l --color=always --group-directories-first --icons'  # long format
    alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
    alias l.="eza -a | grep -e '^\.'"                                   # show only dotfiles
    #  pacman alias
    alias u='sudo pacman -Syu'
    alias i='sudo pacman -S'
    alias s='pacman -Ss'
    alias q='pacman -Qs'
    alias d='sudo pacman -R'
    alias rns='sudo pacman -Rns'
    

    #binds
    # bind \t accept-autosuggestion
    bind \cH backward-kill-word
    bind \b backward-kill-word
    
    bind \t accept-autosuggestion

    # Shift+Tab = show full list
    bind \e\[Z 'complete --list'
    
    function fish_user_key_bindings
        # TAB → normal completion (progressive)
        bind -e tab
        bind -e \t
        bind -M insert \t complete
 # Ctrl+F → accept autosuggestion (LEFT-HAND → key)
    # bind -M insert \c\t accept-autosuggestion
    end

    #export
    fish_add_path /usr/local/go/bin
    #loading nvm ( node version manager ) using bass ( fish plugin manager ) 
    function nvm
        bass source ~/.nvm/nvm.sh --no-use ';' nvm use default
    end
    function mkcd
        mkdir -p $argv[1]; and cd $argv[1]
    end
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end
    function f
        thunar $argv &; disown
    end   
end