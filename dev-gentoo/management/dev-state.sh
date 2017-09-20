#!/bin/bash
#===============================================================================
# dev-state.sh: Returns whether the VM is enabled
#
# Usage: dev-state.sh
#===============================================================================

vmname='BuildSystem'

echo "$(VBoxManage list runningvms | grep -c $vmname)"
