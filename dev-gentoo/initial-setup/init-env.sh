#!/bin/bash
#===============================================================================
# init-env.sh: Creates a new environment for the gentoo build
#
# Usage: init-env.sh <stage3-tarball> <Root Partition> <EFI Partition>
#                    <Boot Partition> <Swap Partition> <hostname>
#                    <Network Device> <Host Device>
#===============================================================================

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

dir=$(dirname "$(readlink -f "$0")")
tarball=$1
root=$2
efi=$3
boot=$4
swap=$5
hostname=$6
nic=$7
host_nic=$8

$dir/init-fstab.sh "$root" "$boot" "$swap"

tar xvjpf $tarball --xattrs --numeric-owner
cp $dir/chroot/config/make.conf /mnt/gentoo/etc/portage/make.conf

mkdir /mnt/gentoo/etc/portage/repos.conf
cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
cp -L /etc/resolv.conf /mnt/gentoo/etc/

mount -t proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev

cp $dir/chroot-setup /mnt/gentoo/chroot-setup
chroot /mnt/gentoo /bin/bash $dir/chroot-setup/init-env-chroot.sh "$efi" "$boot" "$hostname" "$nic" "$host_nic"

rm -rf /mnt/gentoo/chroot-setup
rm $tarball
