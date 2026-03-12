set -g fish_greeting
# set -g autopair_tab false
if status is-interactive

    # Commands to run in interactive sessions can go here
    # run neofetch on start
    fastfetch

    #init
    #starship initialize
    starship init fish | source



    #aliases
    #basic aliases
    alias code 'vscodium'
    alias src 'source ~/.config/fish/config.fish'
    alias cls 'clear'
    
    # alias list exa
    alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
    alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs
    alias ll='eza -l --color=always --group-directories-first --icons'  # long format
    alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
    alias l.="eza -a | grep -e '^\.'"                                     # show only dotfiles
    #  pacman alias
    alias i='sudo pacman -S'
    alias s='pacman -Ss'
    alias q='pacman -Qs'
    

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
        bass source ~/.nvm/nvm.sh ';' nvm $argv 
    end
    
end
