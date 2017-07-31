#!/bin/bash
#===============================================================================
# init-env.sh: Creates a new environment for the gentoo build
#
# Usage: init-env.sh <Root Partition> <Swap Partition>
#===============================================================================

dir=$(dirname "$(readlink -f "$0")")
root=$(blkid -s PARTUUID -o value $1)
swap=$(blkid -s PARTUUID -o value $2)

echo "# /etc/fstab: static file system information.
#
# noatime turns off atimes for increased performance (atimes normally aren't
# needed); notail increases performance of ReiserFS (at the expense of storage
# efficiency).  It's safe to drop the noatime options if you want and to
# switch between notail / tail freely.
#
# The root filesystem should have a pass number of either 0 or 1.
# All other filesystems should have a pass number of 0 or greater than 1.
#
# See the manpage fstab(5) for more information.
#
# <fs>                                          <mountpoint>	<type>  <opts>  <dump>  <pass>
PARTUUID=$root /     ext4 noatime 0 1
PARTUUID=$swap none  swap sw      0 0
" > $dir/chroot/config/fstab
