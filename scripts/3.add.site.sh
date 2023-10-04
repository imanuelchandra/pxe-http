#!/bin/bash

siteconf_pxe="/config/httpd/sites-available/pxelocal.conf"

if [ ! -r "$siteconf_pxe" ]; then
    echo "Please ensure '$siteconf_pxe' exists and is readable."
    exit 1
else
    sudo cp $siteconf_pxe /etc/apache2/sites-available/pxelocal.conf
    echo "File /etc/apache2/sites-available/pxelocal.conf....\n"
    sudo cat /etc/apache2/sites-available/pxelocal.conf
fi

cd /etc/apache2/sites-available/
sudo a2ensite pxelocal.conf
sudo a2dissite 000-default.conf