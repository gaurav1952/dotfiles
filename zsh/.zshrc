export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH=$PATH:/usr/local/bin/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

# Color variables
COLOR_RED='\e[31m'
COLOR_GREEN='\e[32m'
COLOR_YELLOW='\e[33m'
COLOR_BLUE='\e[34m'
COLOR_PURPLE='\e[35m'
COLOR_CYAN='\e[36m'
COLOR_WHITE='\e[37m'
COLOR_RESET='\e[0m'


plugins=(git zsh-autosuggestions zsh-syntax-highlighting )


# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
setopt AUTO_CD


# Basic aliases
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias ll='ls -l'
alias la='ls -a'
#alias f='cd /mnt/f'
alias cls='clear'
alias lt='list'
alias cpp="g++"
alias bat='batcat'
alias info='penguin_ascii_sys'
alias code='vscodium'


# Git aliases
alias gs='git status'
alias gp='git pull'
alias gcm='git commit -m'
alias gl='git log --graph'
alias gd='git diff'
alias ga='git add'
alias gco='git checkout'
alias gb='git branch'
alias grb='git rebase'
alias gst='git stash'
alias glog='git log --oneline --graph --decorate'

alias gitorigin='git remote get-url origin'

# sys 
#alias i='paru -S'
#alias s='paru -Ss'
alias r='sudo pacman -R'
alias rr='sudo pacman -Rns'
alias i='sudo pacman -S'
alias s='sudo pacman -Ss'
alias q='sudo pacman -Qs'
# Directory and file management
# alias mkdir='mkdir -p'
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
# alias df='df -h'
# alias du='du -h'
# alias free='free -h'

# Development aliases
alias py='python3'
alias c='vscodeium .'
alias phpserver='php -S localhost:4000'
# alias work="cd /mnt/f/notes && phpserver"
# alias downloads='cd /mnt/f/downloads'
# alias se='fzf_code'
# alias sn='fzf_nvim'
# alias check='ls -la | grep'
# alias vim='vi'
# alias start='powershell.exe start'


# System aliases
alias top='htop'
alias ports='netstat -tulanp'
alias myip='curl ifconfig.me'
alias weather='curl wttr.in'
alias disk='ncdu'

#for fun
alias cow='cow_ascii'
alias gaurav='system_info'


# Custom function for Brave search
open() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        open -a "Brave Browser" "https://search.brave.com/search?q=$1&source=desktop"
    else
        start Brave "https://search.brave.com/search?q=$1&source=desktop"
    fi
}
# if [ -f /etc/profile ]; then
#   . /etc/profile
# fi

# FZF integration
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
    
    # Custom fzf functions
    fzf_vscode() {
        local file
        file=$(fzf --height 40% --layout=reverse --border) && code "$file"
    }
    
    fzf_vim() {
        local file
        file=$(fzf --height 40% --layout=reverse --border) && nvim "$file"
    }
    
    # Key bindings
    bindkey '^o' fzf_vscode
    bindkey '^n' fzf_vim
fi
#key binding

bindkey '\em' backward-kill-word
bindkey '^I' autosuggest-accept
#################################################
# AUTO START
#################################################
source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"


export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[[ -e ~/.phpbrew/zshrc ]] && source ~/.phpbrew/zshrc[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
