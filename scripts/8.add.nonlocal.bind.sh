#!/bin/bash

sysctl="/config/sysctl/sysctl.conf"

if [ ! -r "$sysctl" ]; then
    echo "Please ensure '$sysctl' exists and is readable."
    exit 1
else
    sudo rm /etc/sysctl.conf
    sudo cp $sysctl /etc/sysctl.conf
    echo "===================================\n"
    echo "File /etc/sysctl.conf\n"
    echo "===================================\n"
    sudo cat /etc/sysctl.conf
    echo "\n"
fi