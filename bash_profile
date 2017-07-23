if [ -e ~/.profile ]; then
    source ~/.profile
fi

YELLOW="$(tput setaf 3)"
MAGENTA="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
WHITE="$(tput setaf 7)"
BOLD="$(tput bold)"
RESET="$(tput sgr0)"
PS1='\[$YELLOW\]$? \[$WHITE$BOLD\][\h]\[$RESET\] \[$CYAN\]\u\[$WHITE\]\[$BOLD\]:\[$MAGENTA\]\w\[$WHITE\] \$\[$RESET\] '

function ssh-reagent() {
    SSH_AUTH_SOCK=~/usr/tmp/ssh-agent.socket
    export SSH_AUTH_SOCK
    if ! ssh-add -l >/dev/null 2>&1; then
        tput setaf 3 1>&2
        echo "Launching ssh agent..." 1>&2
        tput sgr0 1>&2
        SSH_AUTH_SOCK=~/usr/tmp/ssh-agent.socket
        rm -f $SSH_AUTH_SOCK
        eval `ssh-agent -a $SSH_AUTH_SOCK`
        ssh-add ~/auth/*.key >/dev/null
    fi
    export SSH_AGENT_PID=`pgrep ssh-agent | head -n 1`
    tput setaf 2
    echo "ssh-agent PID $SSH_AGENT_PID forwarding:"
    tput bold
    ssh-add -l | awk '{print $3}' | xargs -I{} basename {} | xargs -I{} echo "- {}"
    tput sgr0
}

CLICOLOR=""
export CLICOLOR
ssh-reagent
