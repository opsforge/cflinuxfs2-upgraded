FROM pcfnorm/rootfs:1.0.28

MAINTAINER opsforge.io
LABEL name="cflinuxfs2-upgraded"
LABEL version="0.0.1"
LABEL type="weird"

RUN apt-get update && apt-get install -y jq sshpass ldap-utils python-pip && \
    apt-get clean
    
RUN pip install xlsxwriter requests

RUN apt-get update && apt-get upgrade -y && \
    apt-get clean
