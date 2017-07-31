#!/bin/bash
#===============================================================================
# init-env.sh: Creates a new environment for the gentoo build
#
# Usage: init-env.sh <Root Partition> <Boot Partition> <Swap Partition>
#===============================================================================

dir=$(dirname "$(readlink -f "$0")")
root=$(blkid -s PARTUUID -o value $1)
boot=$(blkid -s PARTUUID -o value $2)
swap=$(blkid -s PARTUUID -o value $3)

echo "PARTUUID=$root /     ext4 noatime 0 1" >> $dir/chroot/config/fstab
echo "PARTUUID=$boot /boot vfat noatime 0 2" >> $dir/chroot/config/fstab
echo "PARTUUID=$swap none  swap sw      0 0" >> $dir/chroot/config/fstab
