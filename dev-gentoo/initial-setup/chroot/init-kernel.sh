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

#TODO: Attach Modules to the system
