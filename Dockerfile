FROM debian:bullseye

MAINTAINER Chandra Lefta <lefta.chandra@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get install -y iproute2 sudo nfs-common fuse bindfs \
                       apache2 apache2-utils
RUN apt clean

RUN groupadd -g 6565 pxeadmin
RUN useradd -d /home/pxeadmin -ms /bin/bash pxeadmin -u 6565 -g 6565
RUN usermod -aG www-data pxeadmin
RUN usermod -aG sudo pxeadmin
RUN passwd -d pxeadmin
RUN echo 'pxeadmin ALL=(ALL) ALL' >> /etc/sudoers 

EXPOSE 80

ADD httpd.sh /httpd.sh
RUN chmod +x /httpd.sh

ENTRYPOINT ["/httpd.sh"]
CMD ["eth0"]