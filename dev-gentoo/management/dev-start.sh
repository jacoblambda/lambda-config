#!/bin/bash
#===============================================================================
# dev-start.sh: Spins up the VM
#
# Usage: dev-start.sh
#===============================================================================

vmname='BuildSystem'

if [ "$(dev-state)" -eq 0 ]; then
    VBoxManage startvm "$vmname" --type headless
fi
