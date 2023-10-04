#!/bin/bash

apache2conf="/config/httpd/apache2.conf"

if [ ! -r "$apache2conf" ]; then
    echo "Please ensure '$apache2conf' exists and is readable."
    exit 1
else
    sudo cp $apache2conf /etc/apache2/apache2.conf
    echo "===================================\n"
    echo "File /etc/apache2/apache2.conf\n"
    echo "===================================\n"
    sudo cat /etc/apache2/apache2.conf
    echo "\n"
fi