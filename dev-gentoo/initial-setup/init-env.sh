#!/bin/bash
#===============================================================================
# init-env.sh: Creates a new environment for the gentoo build
#
# Usage: init-env.sh <stage3-tarball> <EFI Partition> <Boot Partition>
#                    <hostname> <Network Device> <Host Device>
#===============================================================================

dir=$(dirname "$(readlink -f "$0")")
tarball=$1
efi=$2
boot=$3
hostname=$4
nic=$5
host_nic=$6


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
