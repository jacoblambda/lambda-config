#!/bin/bash
#===============================================================================
# init-net.sh: Initialises Network Settings
#
# Usage: init-net.sh <hostname> <Network Device> <Host Device>
#===============================================================================

hostname=$1
nic=$2
host_nic=$3
host_ip="192.168.56.101"

echo "hostname=\"$hostname\"" > /etc/conf.d/hostname
emerge --noreplace net-misc/netifrc

echo "config_$nic=dhcp" > /etc/conf.d/net
echo "config_$host_nic=dhcp" > /etc/conf.d/net

ln -s /etc/init.d/net.lo /etc/init.d/net.$nic
ln -s /etc/init.d/net.lo /etc/init.d/net.$host_nic
rc-update add net.$nic default
rc-update add net.$host_nic default

echo "127.0.0.1 $hostname  localhost" >  /etc/hosts
echo "::1       $hostname  localhost" >> /etc/hosts
echo "$host_ip             web.local" >> /etc/hosts
