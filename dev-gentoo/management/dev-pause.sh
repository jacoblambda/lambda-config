#!/bin/bash
#===============================================================================
# dev-pause.sh: Pauses the VM
#
# Usage: dev-stop.sh
#===============================================================================

vmname='BuildSystem';

if [ "$(dev-state)" -gt 0 ]; then
    VBoxManage controlvm "$vmname" savestate;
fi
