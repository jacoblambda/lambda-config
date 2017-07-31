#!/bin/bash
#===============================================================================
# init-env-chroot.sh: Performs chroot based setup steps
#
# Usage: init-env-chroot.sh <EFI Partition> <Boot Partition> <hostname>
#                           <Network Device> <Host Device>
#===============================================================================

source /etc/profile
dir=$(dirname "$(readlink -f "$0")")
packages=$(cat $dir/config/packagelist | grep -Ev "(^#.*|^$)" | tr '\n' ' ')

efi=$1
boot=$2
hostname=$3
nic=$4
host_nic=$5

mkdir /boot
mount $boot /boot
mkdir /boot/efi
mount $efi /boot/efi

cp $dir/config/package.accept_keywords /etc/portage/package.accept_keywords
emerge --sync --quiet

eselect profile list
read -p "Select a profile: Choose a number" number
eselect profile set $number
emerge --update --deep --newuse @world $packages

bash $dir/init-locale.sh
env-update && source /etc/profile
export EDITOR=/usr/bin/vim

cp $dir/config/fstab /etc/fstab

bash $dir/init-kernel.sh
bash $dir/init-net.sh $hostname $nic $host_nic
bash $dir/init-users.sh

refind-install
vim /boot/efi/refind_linux.conf

bash $dir/init-admin.sh
bash $dir/init-build.sh


exit
