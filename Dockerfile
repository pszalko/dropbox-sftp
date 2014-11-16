FROM ubuntu:14.10
MAINTAINER Przemek Szalko <przemek@mobtitude.com>

ENV DEBIAN_FRONTEND noninteractive 
VOLUME /home/dropbox-sftp/Dropbox


RUN apt-get update && apt-get install -y openssh-server 

ADD https://www.dropbox.com/download?plat=lnx.x86_64 /home/dropbox-sftp/dropbox.tgz
ADD https://www.dropbox.com/download?dl=packages/dropbox.py /home/dropbox-sftp/dropbox.py
RUN tar xfvz /home/dropbox-sftp/dropbox.tgz -C /home/dropbox-sftp && rm /home/dropbox-sftp/dropbox.tgz && chmod a+x /home/dropbox-sftp/dropbox.py
RUN chown -R root:root /home/dropbox-sftp

COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]