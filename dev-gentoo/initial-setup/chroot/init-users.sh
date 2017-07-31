#!/bin/bash
#===============================================================================
# init-users.sh: Configures Users and Groups
#
# Usage: init-users.sh
#===============================================================================

passwd
visudo
vim /etc/conf.d/keymaps

useradd -m -G wheel -s /bin/bash jacoblambda
echo 'Input Password for jacoblambda'
passwd jacoblambda
