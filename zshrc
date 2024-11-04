# Color variables
COLOR_RED='\e[31m'
COLOR_GREEN='\e[32m'
COLOR_YELLOW='\e[33m'
COLOR_BLUE='\e[34m'
COLOR_PURPLE='\e[35m'
COLOR_CYAN='\e[36m'
COLOR_WHITE='\e[37m'
COLOR_RESET='\e[0m'

# Text formatting
BOLD='\e[1m'
UNDERLINE='\e[4m'
BLINK='\e[5m'
REVERSE='\e[7m'
HIDDEN='\e[8m'

# Background colors
BG_RED='\e[41m'
BG_GREEN='\e[42m'
BG_YELLOW='\e[43m'
BG_BLUE='\e[44m'
BG_PURPLE='\e[45m'
BG_CYAN='\e[46m'
BG_WHITE='\e[47m'

# Bright colors
BRIGHT_RED='\e[91m'
BRIGHT_GREEN='\e[92m'
BRIGHT_YELLOW='\e[93m'
BRIGHT_BLUE='\e[94m'
BRIGHT_PURPLE='\e[95m'
BRIGHT_CYAN='\e[96m'
BRIGHT_WHITE='\e[97m'




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
penguin_ascii_sys
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme setting
ZSH_THEME="powerlevel10k/powerlevel10k"

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY

# Completion settings
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format '%F{green}%d%f'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB to view completions.%s

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

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
    
    # Network Information (commented out)
    # echo -e "\n${COLOR_YELLOW}=== Network Information ===${COLOR_RESET}"
    # if command -v ip &> /dev/null; then
    #     echo -e "${COLOR_GREEN}IP Address: $(ip addr show | grep -w inet | grep -v 127.0.0.1 | awk '{print $2}' | cut -d/ -f1)${COLOR_RESET}"
    # else
    #     echo -e "${COLOR_GREEN}IP Address: $(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}')${COLOR_RESET}"
    # fi
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
alias ..='cd ..'
alias ...='cd ../..'
alias lt='list'



# Git aliases
alias gs='git status'
alias gp='git pull'
alias gcm='git commit -m'
alias gl='git log'
alias gd='git diff'
alias ga='git add'
alias gco='git checkout'
alias gb='git branch'
alias grb='git rebase'
alias gst='git stash'
alias glog='git log --oneline --graph --decorate'

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
alias pip='pip3'
alias c='code .'
alias phpserver='php -S localhost:4000'
alias work="cd /mnt/f/notes && phpserver"
alias download='cd /mnt/f/downloads'
alias se='fzf_code'
alias sn='fzf_nvim'



# System aliases
alias top='htop'
alias ports='netstat -tulanp'
alias myip='curl ifconfig.me'
alias weather='curl wttr.in'
alias update='sudo apt update && sudo apt upgrade'
alias disk='ncdu'

#for fun
alias cow='cow_ascii'


# Custom function for Brave search
open() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        open -a "Brave Browser" "https://search.brave.com/search?q=$1&source=desktop"
    else
        start Brave "https://search.brave.com/search?q=$1&source=desktop"
    fi
}
if [ -f /etc/profile ]; then
  . /etc/profile
fi

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



# Gaurav command with ASCII art and system info
alias gaurav='echo -e "\e[33mHello g4aur4v\e[0m" && system_info'

# Load Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
