#!/bin/bash
#===============================================================================
# dev-stop.sh: Shuts down the VM
#
# Usage: dev-stop.sh
#===============================================================================

vmname='BuildSystem';

if [ "$(dev-state)" -gt 0 ]; then
    VBoxManage controlvm "$vmname" acpipowerbutton;
fi
