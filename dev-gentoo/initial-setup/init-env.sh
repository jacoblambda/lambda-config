#!/bin/bash
#===============================================================================
# init-env.sh: Creates a new environment for the gentoo build
#
# Usage: init-env.sh <stage3-tarball> <Root Partition> <EFI Partition>
#                    <Swap Partition> <hostname> <Network Device> <Host Device>
#===============================================================================

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

dir=$(dirname "$(readlink -f "$0")")
tarball=$1
root=$2
efi=$3
swap=$4
hostname=$5
nic=$6
host_nic=$7

mkfs.ext4 $root
mkfs.vfat $efi
mkswap $swap
swapon $swap

mount $root /mnt/gentoo

bash $dir/init-fstab.sh "$root" "$swap"

tar xvjpf $tarball --xattrs --numeric-owner --directory /mnt/gentoo
cp $dir/chroot/config/make.conf /mnt/gentoo/etc/portage/make.conf

mkdir /mnt/gentoo/etc/portage/repos.conf
cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
cp -L /etc/resolv.conf /mnt/gentoo/etc/

mount -t proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev

cp -a $dir/chroot /mnt/gentoo/chroot
chroot /mnt/gentoo /bin/bash /chroot/init-env-chroot.sh "$efi" "$hostname" "$nic" "$host_nic"

rm -rf /mnt/gentoo/chroot
rm $tarball
