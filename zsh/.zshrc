export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH=$PATH:/usr/local/bin/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

# Color variables
COLOR_RED='\e[31m'
COLOR_GREEN='\e[32m'
COLOR_YELLOW='\e[33m'
COLOR_BLUE='\e[34m'
COLOR_PURPLE='\e[35m'
COLOR_CYAN='\e[36m'
COLOR_WHITE='\e[37m'
COLOR_RESET='\e[0m'

cow_ascii() {
    echo -e "${COLOR_YELLOW}"
    echo "                                    /;    ;\\"
    echo "                                   __  \\\\____//"
    echo "                                  /{\_\_/   \`'\\____"
    echo "                                  \\___   (o)  (o  }"
    echo "       _____________________________/          :--'  "
    echo "   ,-,'\`@@@@@@@@       @@@@@@         \\_    \`__\\"
    echo "  ;:(  @@@@@@@@@        @@@             \\___(o'o)"
    echo "  :: )  @@@@          @@@@@@        ,'@@(  \`===='       "
    echo "  :: : @@@@@:          @@@@         \`@@@:"
    echo "  :: \\  @@@@@:       @@@@@@@)    (  '@@@'"
    echo "  ;; /\\      /\`,    @@@@@@@@@\\   :@@@@@)"
    echo "  ::/  )    {_----------------:  :~\`,~~;"
    echo " ;;'\`; :   )                  :  / \` ; ;"
    echo ";;;; : :   ;                  :  ;  ; :              "
    echo "\`'\`' / :  :                   :  :  : :"
    echo "    )_ \\__;      \";\"          :_ ;  \\_\\       \`,','"
    echo "    :__\\  \\    * \`,\'*         \\  \\  :  \\   *  8\`;'*  *"
    echo "        \`^'     \\ :/           \`^'  \`-^-'   \\v/ :  \\/"
    echo -e "${COLOR_RESET}"
}

penguin_ascii_sys() {
    # Gather system information
    USER_INFO="$(whoami)@$(hostname)"
    if command -v lsb_release &> /dev/null; then
        OS_INFO="$(lsb_release -d | cut -f2)"
    elif [ -f /etc/os-release ]; then
        OS_INFO="$(grep '^PRETTY_NAME=' /etc/os-release | cut -d '=' -f2 | tr -d '\"')"
    else
        OS_INFO="Unknown"
    fi
    KERNEL_INFO="$(uname -r)"
    ARCH_INFO="$(uname -m)"
    UPTIME_INFO="$(uptime -p)"
    SHELL_INFO="$SHELL"
    CPU_INFO="$(sysctl -n machdep.cpu.brand_string 2>/dev/null || grep 'model name' /proc/cpuinfo | head -1 | cut -d ':' -f2 | sed 's/^[ \t]*//')"
    CPU_CORES="$(nproc 2>/dev/null || sysctl -n hw.ncpu)"
    MEMORY_TOTAL="$(free -h 2>/dev/null | awk '/Mem:/ {print $2}' || sysctl hw.memsize 2>/dev/null | awk '{print $2/1024/1024/1024 "GB"}')"
    MEMORY_USED="$(free -h 2>/dev/null | awk '/Mem:/ {print $3}' || vm_stat 2>/dev/null | awk '/Pages active/ {print $3 * 4096/1024/1024/1024 "GB"}')"
    DISK_USAGE="$(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')"

    # Print the penguin ASCII art with system info
    echo -e "${COLOR_YELLOW}"
    echo -e "Hello g4ur4v"
    echo "   .--.                  ${COLOR_GREEN} User:  ${USER_INFO}  ${COLOR_YELLOW}"
    echo "  |o_o |                 ${COLOR_BLUE} OS:    ${OS_INFO} ${COLOR_YELLOW}"
    echo "  |:_/ |                  ${COLOR_PURPLE}Kernel:${KERNEL_INFO}${COLOR_YELLOW}"
    echo " //   \\ \\               ${COLOR_CYAN}  Arch:  ${ARCH_INFO} ${COLOR_YELLOW}"
    echo "(|     | )               ${COLOR_YELLOW} Uptime:${UPTIME_INFO}${COLOR_YELLOW}"
    echo "/'\\_   _/\\'              ${COLOR_WHITE} Shell: ${SHELL_INFO}${COLOR_YELLOW}"
    echo "\\___)=(___/            ${COLOR_RED}   CPU:   ${CPU_INFO} ${COLOR_YELLOW}"
    echo "                        ${COLOR_CYAN}  Memory:${MEMORY_USED}/${MEMORY_TOTAL}${COLOR_YELLOW}"
    echo "                         ${COLOR_WHITE} Disk:  ${DISK_USAGE}${COLOR_YELLOW}"
    echo -e "${COLOR_RESET}"
}
# penguin_ascii_sys




# Theme setting
ZSH_THEME="robbyrussell"

# for plugins
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

plugins=(git zsh-autosuggestions zsh-syntax-highlighting )
# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY





# System information function for gaurav command
system_info() {


    echo -e "\n${COLOR_YELLOW}===== System Information =====${COLOR_RESET}\n"
    echo -e "${COLOR_GREEN}User: $(whoami)@$(hostname)${COLOR_RESET}"
    echo -e "${COLOR_BLUE}OS: $(uname -o 2>/dev/null || echo 'Unknown')${COLOR_RESET}"
    echo -e "${COLOR_CYAN}Kernel: $(uname -r)${COLOR_RESET}"
    echo -e "${COLOR_PURPLE}Uptime: $(uptime -p)${COLOR_RESET}"
    CPU_INFO=$(sysctl -n machdep.cpu.brand_string 2>/dev/null || grep "model name" /proc/cpuinfo | head -1 | cut -d ":" -f2 | sed 's/^[ \t]*//')
    echo -e "${COLOR_RED}CPU: ${CPU_INFO}${COLOR_RESET}"
    MEMORY_TOTAL=$(free -h 2>/dev/null | awk '/Mem:/ {print $2}' || sysctl hw.memsize 2>/dev/null | awk '{print $2/1024/1024/1024 "GB"}')
    MEMORY_USED=$(free -h 2>/dev/null | awk '/Mem:/ {print $3}' || vm_stat 2>/dev/null | awk '/Pages active/ {print $3 * 4096/1024/1024/1024 "GB"}')
    echo -e "${COLOR_CYAN}Memory Total: ${MEMORY_TOTAL}${COLOR_RESET}"
    echo -e "${COLOR_CYAN}Memory Used: ${MEMORY_USED}${COLOR_RESET}"
    
    # Disk Usage Information
    DISK_USAGE=$(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')
    echo -e "${COLOR_WHITE}Disk Usage: ${DISK_USAGE}${COLOR_RESET}"
    
    # GPU Information (if available)
    if command -v nvidia-smi &> /dev/null; then
        echo -e "\n${COLOR_YELLOW}=== GPU Information ===${COLOR_RESET}"
        nvidia-smi --query-gpu=gpu_name,memory.total,memory.used --format=csv,noheader
    fi
    
  
}

# fzf for vs code 
fzf_code() {
    fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' | xargs -r code
}
# fzf for nvim 
fzf_nvim() {
    fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' | xargs -r nvim
}
# Basic aliases
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias ll='ls -l'
alias la='ls -a'
alias f='cd /mnt/f'
alias cls='clear'
# alias lt='list'
alias cpp='g++'
alias ..='cd ..'
alias ...='cd ../..'
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
alias i='paru -S'
alias s='paru -Ss'
alias r='sudo pacman -R'
alias rr='sudo pacman -Rns'
alias p='sudo pacman'

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
alias c='code .'
alias phpserver='php -S localhost:4000'
alias work="cd /mnt/f/notes && phpserver"
alias downloads='cd /mnt/f/downloads'
alias se='fzf_code'
alias sn='fzf_nvim'
alias check='ls -la | grep'
alias vim='vi'
alias start='powershell.exe start'


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
[[ -e ~/.phpbrew/zshrc ]] && source ~/.phpbrew/zshrc