if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    alias src 'source ~/.dotfiles/fish/.config/config.fish'
end
