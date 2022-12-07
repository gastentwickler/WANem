#!/bin/bash

set -x

if [[ $UID -ne 0 ]]; then
	echo "Configuration has to be run as root!"
	exit 1
fi

### configure the 2 physical interfaces

/usr/sbin/service network-manager stop
sleep 5

# internal nic
ifname_init=$(/sbin/ip addr | grep -i broadcast | awk -F: '{print $2}' | sed 's/[[:blank:]]//g' | grep ^enp)
if [ -n "${ifname_init}" ]; then
	/sbin/ip link set ${ifname_init} down
	sleep 2
	/sbin/ip link set ${ifname_init} name eth0
	/sbin/ip link set eth0 up
	systemctl restart network
fi

# usb nic
ifname_init=$(/sbin/ip addr | grep -i broadcast | awk -F: '{print $2}' | sed 's/[[:blank:]]//g' | grep ^enx)
if [ -n "${ifname_init}" ]; then
	/sbin/ip link set ${ifname_init} down
	sleep 2
	/sbin/ip link set ${ifname_init} name eth1
	/sbin/ip link set eth1 up
	systemctl restart network
fi


ETH_OS_OPS=eth0
ETH_OS_NOPS=eth0
ETH_BS_OPS=eth0
ETH_BS_NOPS=eth0


# RefSys Betrieb OPS
/sbin/ip link add link $ETH_OS_OPS name $ETH_OS_OPS.3250 type vlan id 3250
/sbin/ip link set $ETH_OS_OPS.3250 up
/sbin/ifconfig $ETH_OS_OPS.3250 10.234.16.254/24

/sbin/ip link add link $ETH_OS_OPS name $ETH_OS_OPS.3251 type vlan id 3251
/sbin/ip link set $ETH_OS_OPS.3251 up
/sbin/ifconfig $ETH_OS_OPS.3251 10.234.17.254/24

/sbin/ip link add link $ETH_OS_OPS name $ETH_OS_OPS.3252 type vlan id 3252
/sbin/ip link set $ETH_OS_OPS.3252 up
/sbin/ifconfig $ETH_OS_OPS.3252 10.234.18.254/24

/sbin/ip link add link $ETH_OS_OPS name $ETH_OS_OPS.3253 type vlan id 3253
/sbin/ip link set $ETH_OS_OPS.3253 up
/sbin/ifconfig $ETH_OS_OPS.3253 10.234.19.254/24


# RefSys Betrieb NON OPS
/sbin/ip link add link $ETH_OS_NOPS name $ETH_OS_NOPS.3254 type vlan id 3254
/sbin/ip link set $ETH_OS_NOPS.3254 up
/sbin/ifconfig $ETH_OS_NOPS.3254 10.234.20.254/24

/sbin/ip link add link $ETH_OS_NOPS name $ETH_OS_NOPS.3255 type vlan id 3255
/sbin/ip link set $ETH_OS_NOPS.3255 up
/sbin/ifconfig $ETH_OS_NOPS.3255 10.234.21.254/24

/sbin/ip link add link $ETH_OS_NOPS name $ETH_OS_NOPS.3256	 type vlan id 3256
/sbin/ip link set $ETH_OS_NOPS.3256 up
/sbin/ifconfig $ETH_OS_NOPS.3256 10.234.22.254/24

/sbin/ip link add link $ETH_OS_NOPS name $ETH_OS_NOPS.3257 type vlan id 3257
/sbin/ip link set $ETH_OS_NOPS.3257 up
/sbin/ifconfig $ETH_OS_NOPS.3257 10.234.23.254/24


# RefSys Backup OPS
/sbin/ip link add link $ETH_BS_OPS name $ETH_BS_OPS.3262 type vlan id 3262
/sbin/ip link set $ETH_BS_OPS.3262 up
/sbin/ifconfig $ETH_BS_OPS.3262 10.234.28.254/24

/sbin/ip link add link $ETH_BS_OPS name $ETH_BS_OPS.3263 type vlan id 3263
/sbin/ip link set $ETH_BS_OPS.3263 up
/sbin/ifconfig $ETH_BS_OPS.3263 10.234.29.254/24

/sbin/ip link add link $ETH_BS_OPS name $ETH_BS_OPS.3264 type vlan id 3264
/sbin/ip link set $ETH_BS_OPS.3264 up
/sbin/ifconfig $ETH_BS_OPS.3264 10.234.30.254/24

/sbin/ip link add link $ETH_BS_OPS name $ETH_BS_OPS.3265 type vlan id 3265
/sbin/ip link set $ETH_BS_OPS.3265 up
/sbin/ifconfig $ETH_BS_OPS.3265 10.234.31.254/24


# RefSys Backup NON OPS
/sbin/ip link add link $ETH_BS_NOPS name $ETH_BS_NOPS.3266 type vlan id 3266
/sbin/ip link set $ETH_BS_NOPS.3266 up
/sbin/ifconfig $ETH_BS_NOPS.3266 10.236.24.254/24

/sbin/ip link add link $ETH_BS_NOPS name $ETH_BS_NOPS.3267 type vlan id 3267
/sbin/ip link set $ETH_BS_NOPS.3267 up
/sbin/ifconfig $ETH_BS_NOPS.3267 10.236.25.254/24

/sbin/ip link add link $ETH_BS_NOPS name $ETH_BS_NOPS.3268 type vlan id 3268
/sbin/ip link set $ETH_BS_NOPS.3268 up
/sbin/ifconfig $ETH_BS_NOPS.3268 10.236.26.254/24

/sbin/ip link add link $ETH_BS_NOPS name $ETH_BS_NOPS.3269 type vlan id 3269
/sbin/ip link set $ETH_BS_NOPS.3269 up
/sbin/ifconfig $ETH_BS_NOPS.3269 10.236.27.254/24

/sbin/ethtool -K $ETH_OS_OPS tso off gro off gso off tx off rx off rxhash off
/sbin/ethtool -K $ETH_OS_OPS.3250 tso off gro off gso off tx off 
/sbin/ethtool -K $ETH_OS_OPS.3251 tso off gro off gso off tx off 
/sbin/ethtool -K $ETH_OS_OPS.3252 tso off gro off gso off tx off 
/sbin/ethtool -K $ETH_OS_OPS.3253 tso off gro off gso off tx off 

/sbin/ethtool -K $ETH_OS_NOPS tso off gro off gso off tx off rx off rxhash off
/sbin/ethtool -K $ETH_OS_NOPS.3254 tso off gro off gso off tx off
/sbin/ethtool -K $ETH_OS_NOPS.3255 tso off gro off gso off tx off
/sbin/ethtool -K $ETH_OS_NOPS.3256 tso off gro off gso off tx off
/sbin/ethtool -K $ETH_OS_NOPS.3257 tso off gro off gso off tx off

/sbin/ethtool -K $ETH_BS_OPS tso off gro off gso off tx off rx off rxhash off
/sbin/ethtool -K $ETH_BS_OPS.3262 tso off gro off gso off tx off 
/sbin/ethtool -K $ETH_BS_OPS.3263 tso off gro off gso off tx off 
/sbin/ethtool -K $ETH_BS_OPS.3264 tso off gro off gso off tx off 
/sbin/ethtool -K $ETH_BS_OPS.3265 tso off gro off gso off tx off 

/sbin/ethtool -K $ETH_BS_NOPS tso off gro off gso off tx off rx off rxhash off
/sbin/ethtool -K $ETH_BS_NOPS.3266 tso off gro off gso off tx off
/sbin/ethtool -K $ETH_BS_NOPS.3267 tso off gro off gso off tx off
/sbin/ethtool -K $ETH_BS_NOPS.3268 tso off gro off gso off tx off
/sbin/ethtool -K $ETH_BS_NOPS.3269 tso off gro off gso off tx off

echo 1 > /proc/sys/net/ipv4/ip_forward

# /sbin/ifconfig

# Zusätzliches Interface für Anbindung an DFS CoreLAN Richtung Firewall (Bomgar und Tacs anbindung)
/sbin/ifconfig eth1 10.233.214.177/28
/sbin/route add default gw 10.233.214.190

/usr/sbin/service network-manager stop
sleep 5
