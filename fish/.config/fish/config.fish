set -g fish_greeting

if status is-interactive

    # Commands to run in interactive sessions can go here
    # run neofetch on start
    fastfetch

    #init
    #starship initialize
    starship init fish | source

    #aliases
    alias src 'source ~/.dotfiles/fish/.config/config.fish'
    alias ll 'exa -l'
    alias cls clear
    alias list exa


    #binds
    bind \t accept-autosuggestion
    bind \eo complete
    bind \cH backward-kill-word
    bind \b backward-kill-word
end
