FROM pcfnorm/rootfs:1.0.28

MAINTAINER opsforge.io
LABEL name="cflinuxfs2-upgraded"
LABEL version="0.1.0"
LABEL type="weird"

# UNDO THE UNSPEAKABLE THINGS THAT HAVE BEEN DONE TO THIS TRUSTY
RUN mkdir -p /etc/apt/apt.conf.d && mkdir -p /etc/apt/preferences.d
RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty universe
    deb-src http://archive.ubuntu.com/ubuntu/ trusty universe
    deb http://archive.ubuntu.com/ubuntu/ trusty-updates universe
    deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates universe
    
    deb http://archive.ubuntu.com/ubuntu/ trusty main
    deb-src http://archive.ubuntu.com/ubuntu/ trusty main
    deb http://archive.ubuntu.com/ubuntu/ trusty-updates main
    deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates main
    
    deb http://archive.ubuntu.com/ubuntu/ trusty restricted
    deb-src http://archive.ubuntu.com/ubuntu/ trusty restricted
    deb http://archive.ubuntu.com/ubuntu/ trusty-updates restricted
    deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates restricted
    
    deb http://archive.ubuntu.com/ubuntu/ trusty multiverse
    deb-src http://archive.ubuntu.com/ubuntu/ trusty multiverse
    deb http://archive.ubuntu.com/ubuntu/ trusty-updates multiverse
    deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates multiverse" > /etc/apt/sources.list

RUN apt-get update && apt-get install --force-yes -y jq sshpass ldap-utils python-pip && \
    apt-get clean
    
RUN pip install xlsxwriter requests

RUN apt-get update && apt-get upgrade --force-yes -y && \
    apt-get clean
