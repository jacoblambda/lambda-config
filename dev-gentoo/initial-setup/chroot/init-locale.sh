#!/bin/bash
#===============================================================================
# init-locale.sh: Configures locale settings
#
# Usage: init-locale.sh
#===============================================================================

echo "America/New_York" > /etc/timezone
emerge --config sys-libs/timezone-data

sed -i 's/#en_US\.UTF-8 UTF-8/en_US\.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
eselect locale set en_US.utf8

rc-update add ntp-client default
rc-service ntp-client start

