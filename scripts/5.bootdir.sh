#!/bin/bash

sudo chown pxeadmin:pxeadmin /data
sudo chmod -R 777 /data
mkdir /home/pxeadmin/boot
sudo bindfs --force-user=pxeadmin --force-group=pxeadmin \
    --create-for-user=6565 --create-for-group=6565 \
    --chown-ignore --chgrp-ignore \
    /data /home/pxeadmin/boot
sudo chmod -R 777 /home/pxeadmin/boot
echo "===================================\n"
echo "Volume Local \n"
echo "===================================\n"
ls /data
echo "\n"
echo "===================================\n"
echo "Boot Directory \n"
echo "===================================\n"
ls -lah /home/pxeadmin/boot