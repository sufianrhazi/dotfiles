#!/bin/bash
if [ -e ~/.bashrc ]; then
    . ~/.bashrc
fi

# Extended colorizing commands
. ~/bin/display.sh


# 256 color support
alias tmux="tmux -2"
export PS1="`color_fg -bash 48 48 0`\$? `color_clear -bash``color_fg -bash 96 96 96`\h`color_clear -bash`:`color_fg -bash 96 32 96`\w`color_clear -bash` `color_fg -bash 255 255 255`\u\$`color_clear -bash` "
export CLICOLOR=""
export LSCOLORS=$(cat /etc/LSCOLORS)

# ssh agent
ssh-reagent () {
    for agent in /tmp/ssh-*/agent.*; do
        export SSH_AUTH_SOCK=$agent
        if ssh-add -l 2>&1 > /dev/null; then
            color_fg 0 255 0
            echo "Found ssh-agent ($agent):"
            color_fg 255 255 255
            ssh-add -l | awk '{ print "-",$3 }'
            color_clear
            return 0
        fi
    done
    return 1
}
if ! ssh-reagent; then
    color_fg 255 255 0
    echo "Cannot find running ssh-agent. Relaunching..."
    color_clear
    eval `ssh-agent`
    color_fg 255 255 255
    ssh-add ~/auth/*.key
    color_clear
fi
