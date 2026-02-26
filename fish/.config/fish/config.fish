set -g fish_greeting

if status is-interactive

    # Commands to run in interactive sessions can go here
    # run neofetch on start
    fastfetch

    #init
    #starship initialize
    starship init fish | source


    #export
    fish_add_path /usr/local/go/bin

    #aliases
    alias src 'source ~/.config/fish/config.fish'
    alias cls clear
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
    bind \t accept-autosuggestion
    bind \eo complete
    bind \cH backward-kill-word
    bind \b backward-kill-word
end
