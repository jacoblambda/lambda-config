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
sed -i 's/march=skylake/march=native/' /etc/portage/make.conf

emerge --ask --emptytree --verbose sys-devel/gcc sys-libs/glibc
gcc-config --list-profiles
read -p "Select a profile: Choose a number: " number2
gcc-config $number2
env-update && source /etc/profile

sed -i 's/march=native/march=skylake/' /etc/portage/make.conf
emerge --ask --emptytree --verbose --newuse @world $packages
emerge --ask --depclean

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
refind_conf='/boot/efi/EFI/BOOT/refind_linux.conf'
sed -i -e 's|timeout.*|timeout -1|' $refind_conf
vim $refind_conf

bash $dir/init-admin.sh
bash $dir/init-build.sh

exit
