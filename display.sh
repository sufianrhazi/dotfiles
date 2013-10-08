#!/bin/bash

FG=$'\x1b[38;5;' # ]
BG=$'\x1b[48;5;' # ]
RESET=$'\x1b[0;0' # ]
END=$'m'

EX_FG='\[\e[38;5;' #]
EX_BG='\[\e[48;5;' # ]
EX_RESET='\[\e[0;0' # ] [
EX_END='m\]'

function color_cube() {
    local R=$1
    local G=$2
    local B=$3
    if [ "$R" == "$G" -a "$G" == "$B" ]; then
        if [ "$R" == "0" ]; then
            echo 0
        else
            echo $((232 + R * 24 / 256))
        fi
    else
        echo $((16 + (R*6/256)*36 + (G*6/256)*6 + (B*6/256)))
    fi
}
function color_clear() {
    if [ "$1" == "-bash" ]; then
        local STYLE="${EX_RESET}"
        local END_CMD="${EX_END}"
        shift 1
    else
        local STYLE="${RESET}"
        local END_CMD="${END}"
    fi
    echo -n "${STYLE}${END_CMD}"
}
function color_fg() {
    if [ "$1" == "-bash" ]; then
        local STYLE="${EX_FG}"
        local END_CMD="${EX_END}"
        shift 1
    else
        local STYLE="${FG}"
        local END_CMD="${END}"
    fi
    local COLOR=`color_cube $1 $2 $3`
    echo -n "${STYLE}${COLOR}${END_CMD}"
}
function color_bg() {
    if [ "$1" == "-bash" ]; then
        local STYLE="${EX_BG}"
        local END_CMD="${EX_END}"
        shift 1
    else
        local STYLE="${BG}"
        local END_CMD="${END}"
    fi
    local COLOR=`color_cube $1 $2 $3`
    echo -n "${STYLE}${COLOR}${END_CMD}"
}
