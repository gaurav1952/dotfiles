export PATH=/usr/local/go/bin:$PATH
export PATH="$PATH:/opt/nvim-linux64/bin"


#define colors
# RED="\[\033[1;31m\]"
# GREEN="\[\033[1;32m\]"
# BLUE="\[\033[1;34m\]"
# YELLOW="\[\033[1;33m\]"
# MAGENTA="\[\033[1;35m\]"
# RESET="\[\033[0m\]"
BOLD_BLUE="\[\033[1;34m\]"
BOLD_GREEN="\[\033[1;32m\]"
BOLD_YELLOW="\[\033[1;33m\]"
RESET_COLOR="\[\033[0m\]"


# History settings
export HISTFILE=~/.bash_history
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredupes:ignorespace
export PROMPT_COMMAND="history -a; history -n;"
shopt -s histappend

# Custom aliases similar to Git Bash
alias ll='ls -l'
alias la='ls -A'
alias cls='clear'
alias c='code .'
alias f='cd /mnt/f'
alias gpp='g++'
alias brave="start brave"
alias phpserver="php -S localhost:4000"
alias file="explorer ."
alias b='cd ..'
alias vim='nvim'
alias cbash='nano ~/.bashrc'
# add ctrl backspace delelte word
bind '"\C-h": backward-kill-word'
# Bind `Ctrl + P` and `Ctrl + N` for history-based suggestions
 bind '"\e[A": history-search-backward' # Up arrow
 bind '"\e[B": history-search-forward'  # Down arrow

# Git branch display in prompt
gitPrompt() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always)
        if [ -n "$(git status --porcelain)" ]; then
            echo " ($branch*)"
        else
            echo " ($branch)"
        fi
    fi
}

# Virtual Environment display
function show_venv() {
  if [ -n "$VIRTUAL_ENV" ]; then
    echo -e "(venv: ${VIRTUAL_ENV##*/})"
  fi
}

# Pretty prompt
#PS1='\[\e[32m\]\u@\h:\[\e[36m\]\w\[\e[33m\]$(gitPrompt) $(show_venv)\[\e[0m\]> '
#PS1='\[\e[1;34m\]\u@\h \[\e[1;32m\]\w\[\e[0m\] \[\033[s\033[1;80H\033[1;33m$(date +"%H:%M:%S")\033[u\n$
#PS1="${BOLD_BLUE}\u@\h ${BOLD_GREEN}\w${RESET_COLOR} \[\033[s\033[1;$(($(tput cols)-10))H${BOLD_YELLOW}$(date +'%H:%M:%S')\033[u\]\n${MAGENTA}➔ ${RESET_COLOR}"
# export PS1

# Define color variables for styling


PS1="[${BOLD_YELLOW}\$(date +'%H:%M:%S')${RESET_COLOR}] ${BOLD_BLUE}\u@\h${RESET_COLOR}:${BOLD_GREEN}\w${RESET_COLOR} \n${MAGENTA}➔ ${RESET_COLOR}"
export PS1





# Load bash completion if available
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
alias vim=nvim
