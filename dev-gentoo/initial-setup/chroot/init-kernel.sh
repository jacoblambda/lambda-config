#!/bin/bash
#===============================================================================
# init-kernel.sh: Performs kernel building and initialisation
#
# Usage: init-kernel.sh
#===============================================================================

dir=$(dirname "$(readlink -f "$0")")



cp $dir/config/kernel.conf /usr/src/linux/.config
cd /usr/src/linux || exit
make oldconfig && make menuconfig
make -j5 && make modules_install
make install
cd $dir || exit

src_loc='/usr/src/linux'
kernel_ver=$(readlink -f "$src_loc" | sed -e 's|/usr/src/linux-||' | tr '.' '_' | tr '-' '_')
modules=$(cat /usr/src/linux/modules.order | sed -e 's|\(.*\)/||' -e 's|\.ko||' | tr '\n' ' ')
echo "modules_$kernel_ver=\"$modules\"" >> /etc/conf.d/modules
