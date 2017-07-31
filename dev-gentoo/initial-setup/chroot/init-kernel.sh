#!/bin/bash
#===============================================================================
# init-kernel.sh: Performs kernel building and initialisation
#
# Usage: init-kernel.sh
#===============================================================================

dir=$(dirname "$(readlink -f "$0")")



cp $dir/config/kernel.conf /usr/src/linux/.config
make oldconfig && make menuconfig
make -j5 && make modules_install
make install

modules=$(find "/lib/modules/$(uname -r)/" -type f -iname '*.o' -or -iname '*.ko' | tr '\n' ' ')
echo "modules=$modules" > /etc/conf.d/modules
