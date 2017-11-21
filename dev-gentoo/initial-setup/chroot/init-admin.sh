#!/bin/bash
#===============================================================================
# init-admin.sh: Initialises and Configures basic administrative features such
#               as updating, cronjobs, logging, SSH, etc.
#
# Usage: init-admin.sh <Host Device>
#===============================================================================

dir=$(dirname "$(readlink -f "$0")")
host_nic=$1

#Configure Cron
rc-update add cronie default

#Fuck Logging for now, it doesnt compile for some reason //Configure Logging
#Configure /etc/syslog.conf
#Configure logrotate
#Add zpaq compression to logrotate
sed -i -e 's|#rc_logger="NO"|rc_logger="YES"|' /etc/rc.conf


#Configure SSH Server
/usr/bin/ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ""
/usr/bin/ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ""
rc-update add sshd default

#Configure SFTP Server
cp $dir/config/vsftpd.conf /etc/vsftpd/vsftpd.conf
rc-update add vsftpd default
chown ftp /home/ftp

#Configure Samba Share
sed -i -e "s|enp0s8|$host_nic|" $dir/config/smb.conf
cp $dir/config/smb.conf /etc/samba/smb.conf
rc-update add samba default

#Configure HTTP Server
cp $dir/config/nginx.conf /etc/nginx/nginx.conf
rc-update add nginx default

#Configure Certbot & LetsEncrypt
