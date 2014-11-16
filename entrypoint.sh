#!/bin/sh

set -e

if [ -z $USER_NAME ] || [ -z $USER_PASSWORD ]
then
	echo "Please set \$USER_NAME and \$USER_PASSWORD when starting this container.";
	exit 1;
fi


# Create new user 
if ! id -u $USER_NAME > /dev/null 2>&1; 
then
	useradd -d "/${USER_NAME}" -U -s /bin/false ${USER_NAME}
	mkdir -p "/home/dropbox-sftp/Dropbox/${USER_NAME}"
	chown ${USER_NAME}:${USER_NAME} "/home/dropbox-sftp/Dropbox/${USER_NAME}"
	echo "${USER_NAME}:${USER_PASSWORD}" | chpasswd
	chmod ag+rx "/home/dropbox-sftp/Dropbox"	
fi

service ssh start
HOME=/home/dropbox-sftp /home/dropbox-sftp/.dropbox-dist/dropboxd

