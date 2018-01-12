#!/bin/bash
#===============================================================================
# init-users.sh: Configures Users and Groups
#
# Usage: init-users.sh
#===============================================================================

passwd
visudo
vim /etc/conf.d/keymaps


echo 'Input Password for root'
passwd

CURUSER=jacoblambda

useradd -m -G wheel -s /bin/bash $CURUSER
echo "Input Password for $CURUSER"
passwd $CURUSER

echo "Input Samba Password for $CURUSER(Same as user password)"
smbpasswd -a $CURUSER

echo -n "Input Git Name for $CURUSER: "
read GITNAME
echo -n "Input Git Email for $CURUSER: "
read GITEMAIL

sudo -u $CURUSER git config --global user.name "$GITNAME"
sudo -u $CURUSER git config --global user.email $GITEMAIL
sudo -u $CURUSER git config --global alias.all '!f() { ls -R -d */.git | sed 's,\/.git,,' | xargs -I{} bash -c "echo \"Current Repository: {}\" && git -C {} $1;"; }; f'
sudo -u $CURUSER git config --global core.editor vim
sudo -u $CURUSER git config --global credential.helper cache
