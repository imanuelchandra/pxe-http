#!/bin/bash

portsconf="/config/httpd/ports.conf"

if [ ! -r "$portsconf" ]; then
    echo "Please ensure '$portsconf' exists and is readable."
    exit 1
else
    sudo rm /etc/apache2/ports.conf
    sudo cp $portsconf /etc/apache2/ports.conf
    echo "===================================\n"
    echo "File /etc/apache2/ports.conf\n"
    echo "===================================\n"
    sudo cat /etc/apache2/ports.conf
    echo "\n"
fi