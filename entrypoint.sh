#!/bin/bash

# Trigger an error if non-zero exit code is encountered
set -e 

# Decide what is to replace this process
if [ $# -eq 1 -a -n "$1" ]; then
    if ! which "$1" >/dev/null; then
        # loop until interface is found, or we give up
        NEXT_WAIT_TIME=1
        until [ -e "/sys/class/net/$1" ] || [ $NEXT_WAIT_TIME -eq 4 ]; do
            sleep $(( NEXT_WAIT_TIME++ ))
            echo "Waiting for interface '$1' to become available... ${NEXT_WAIT_TIME}"
        done
        if [ -e "/sys/class/net/$1" ]; then

            container_id=$(grep docker /proc/self/cgroup | sort -n | head -n 1 | cut -d: -f3 | cut -d/ -f3)
            if perl -e '($id,$name)=@ARGV;$short=substr $id,0,length $name;exit 1 if $name ne $short;exit 0' $container_id $HOSTNAME; then
                echo "You must add the 'docker run' option '--net=host' if you want to provide DHCP service to the host network."
            fi

            apache2conf="/apache2.conf"

            if [ ! -r "$apache2conf" ]; then
                echo "Please ensure '$apache2conf' exists and is readable."
                exit 1
            else
                sudo cp $apache2conf /etc/apache2/apache2.conf
                echo "File /etc/apache2/apache2.conf....\n"
                sudo cat /etc/apache2/apache2.conf
                echo "\n"
            fi

            apache2conf_pxe="/pxelocal.conf"

            if [ ! -r "$apache2conf_pxe" ]; then
                echo "Please ensure '$apache2conf_pxe' exists and is readable."
                exit 1
            else
                sudo cp $apache2conf_pxe /etc/apache2/sites-available/pxelocal.conf
                echo "File /etc/apache2/sites-available/pxelocal.conf....\n"
                sudo cat /etc/apache2/sites-available/pxelocal.conf
            fi

            cd /etc/apache2/sites-available/
            sudo a2ensite pxelocal.conf
            sudo a2dissite 000-default.conf

            sudo apachectl -D FOREGROUND
        fi
    fi
else
    # An unknown command (debugging the container?): Forward as is
    exec ${@}
fi