FROM debian:bullseye

MAINTAINER Chandra Lefta <lefta.chandra@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get install -y iproute2 sudo nfs-common \
                       apache2 apache2-utils

RUN groupadd -g 6565 pxeboot
RUN useradd -d /home/pxeboot -ms /bin/bash pxeboot -u 6565 -g 6565
RUN usermod -a -G www-data pxeboot
RUN usermod -a -G root pxeboot
RUN usermod -aG sudo pxeboot
RUN passwd -d pxeboot
RUN echo 'pxeboot ALL=(ALL) ALL' >> /etc/sudoers

RUN apt clean 

ENV NAME pxeboot
ENV HOME /home/pxeboot

WORKDIR /home/pxeboot

VOLUME /home/pxeboot

EXPOSE 80

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["eth0"]