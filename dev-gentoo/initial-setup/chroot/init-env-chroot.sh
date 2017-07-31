#!/bin/bash
#===============================================================================
# init-env-chroot.sh: Performs chroot based setup steps
#
# Usage: init-env-chroot.sh <EFI Partition> <hostname> <Network Device>
#                           <Host Device>
#===============================================================================

source /etc/profile
dir=$(dirname "$(readlink -f "$0")")
packages=$(cat $dir/config/packagelist | grep -Ev "(^#.*|^$)" | tr '\n' ' ')

efi=$1
hostname=$2
nic=$3
host_nic=$4

cp $dir/config/package.accept_keywords /etc/portage/package.accept_keywords
emerge --sync --quiet

eselect profile list
read -p "Select a profile: Choose a number: " number
eselect profile set $number
sed -i 's/march=skylake/march=native/' $dir/config/make.conf
emerge --ask --update --deep --newuse sys-devel/gcc sys-libs/glibc
sed -i 's/march=native/march=skylake/' $dir/config/make.conf
emerge -e --ask --update --deep --newuse @world $packages


bash $dir/init-locale.sh
env-update && source /etc/profile
export EDITOR=/usr/bin/vim

cp $dir/config/fstab /etc/fstab

bash $dir/init-kernel.sh
bash $dir/init-net.sh $hostname $nic $host_nic
bash $dir/init-users.sh

refind-install --usedefault $efi
mkdir /boot/efi
mount $efi /boot/efi
vim /boot/efi/refind_linux.conf

bash $dir/init-admin.sh
bash $dir/init-build.sh

exit
