#!/bin/bash
# Script for turning on or off the ipv6 tunnel from https://www.goipv6.hk

DEV=hk-ipv6
V6LOCAL=2001:2e0:6002:8311::2/64
V4REMOTE=218.213.65.154
TTL=255

function check_args {
    if [ $# -lt 1 ]; then
        echo "$0 on/off <v4 address>"
        exit 1
    fi
}

function tunon {
    ifconfig $DEV >& /dev/null
    if [ $? -eq 0 ]; then
        echo "$DEV already up"
        exit 1
    fi
    sudo ip tunnel add $DEV mode sit remote $V4REMOTE ttl $TTL
    sudo ip link set $DEV up
    sudo ip addr add $V6LOCAL dev $DEV
    sudo ip route add ::/0 dev $DEV
}

function tunoff {
    ifconfig $DEV &>/dev/null
    if [ $? -ne 0 ]; then
      echo "Interface $DEV does not exist"
      return
    fi

    sudo ip link set $DEV down
    sudo ip tunnel del $DEV
}

function help {
    echo "Add following line to /etc/resolv.conf"
    echo "nameserver 2001:4860:4860::8888"
    echo "nameserver 2001:4860:4860::8844"
}

check_args $*

if [ $1 == "on" ]; then
    shift
    V4LOCAL=$1
    check_args $*
    tunon
    help
elif [ $1 == "off" ]; then
    tunoff
else
    shift
    check_args $*
fi



