#!/bin/bash
#===============================================================================
# dev-login.sh: Spins up the VM if it is not already running and SSH into it.
#
# Usage: dev-login.sh
#===============================================================================

ip="192.168.56.101"
user="jacoblambda"
state="$(dev-state)"
dev-start
padding_width=2
if [ $state -eq 0 ]; then
    for (( i = 30; i >= 0; i-- )); do
        printf "%0*d" $padding_width $i
        sleep 1s
        echo -ne "\r\r"
    done
    echo -ne '\n'
fi
ssh $user@$ip
