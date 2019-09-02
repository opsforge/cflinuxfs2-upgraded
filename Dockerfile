FROM pcfnorm/rootfs:1.0.28

MAINTAINER opsforge.io
LABEL name="cflinuxfs2-upgraded"
LABEL version="0.2.0"
LABEL type="weird"

# UNDO THE UNSPEAKABLE THINGS THAT HAVE BEEN DONE TO THIS TRUSTY
RUN mkdir -p /etc/apt/apt.conf.d && mkdir -p /etc/apt/preferences.d
RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty universe \n\
deb-src http://archive.ubuntu.com/ubuntu/ trusty universe \n\
deb http://archive.ubuntu.com/ubuntu/ trusty-updates universe \n\
deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates universe \n\
\n\
deb http://archive.ubuntu.com/ubuntu/ trusty main \n\
deb-src http://archive.ubuntu.com/ubuntu/ trusty main \n\
deb http://archive.ubuntu.com/ubuntu/ trusty-updates main \n\
deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates main \n\
\n\
deb http://archive.ubuntu.com/ubuntu/ trusty restricted \n\
deb-src http://archive.ubuntu.com/ubuntu/ trusty restricted \n\
deb http://archive.ubuntu.com/ubuntu/ trusty-updates restricted \n\
deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates restricted \n\
\n\
deb http://archive.ubuntu.com/ubuntu/ trusty multiverse \n\
deb-src http://archive.ubuntu.com/ubuntu/ trusty multiverse \n\
deb http://archive.ubuntu.com/ubuntu/ trusty-updates multiverse \n\
deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates multiverse" > /etc/apt/sources.list

RUN apt-get update && apt-get install --force-yes -y jq sshpass ldap-utils python-pip && \
    cp $(which jq) /usr/bin/jq-15 && \
    apt-get clean
    
RUN pip install xlsxwriter requests

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade --force-yes -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" && \
    apt-get clean

RUN cd /tmp && \
    curl -L -o cf.deb "https://cli.run.pivotal.io/stable?release=debian64&source=github" && \
    dpkg -i cf.deb && \
    rm -rf /tmp/*
