#!/bin/bash

set -e

# install packages
sudo apt-get update
sudo apt-get install -y \
  git vim-nox python-pip python-dev exuberant-ctags \
  docker.io libvirt-bin kvm \
  openvswitch-switch \
  libxslt1-dev libmysqlclient-dev \
  python-software-properties

sudo adduser $(whoami) docker

sudo pip install -U pip setuptools ansible virtualenv tox

# make directories
function mkmydir() {
    local dirpath=$1
    if [ ! -d ${dirpath} ]
    then
        sudo mkdir ${dirpath}
        sudo chown $(whoami):$(whoami) ${dirpath}
    fi
}

mkmydir ~/bin
mkmydir ~/.ssh
mkmydir /etc/ansible

# setup around ssh
if [ ! -f ~/.ssh/id_rsa ]
then
    ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa
fi

touch ~/.ssh/config ~/.ssh/authorized_keys
chmod 600 ~/.ssh/*

# setup around ansible

cat << EOF > /etc/ansible/hosts
local ansible_connection=local
EOF

cat << EOF > /etc/ansible/ansible.cfg
[defaults]
host_key_checking=False
log_path=ansible.log
EOF

# setup nsenter
if ! which nsenter
then
	sudo docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter
fi

if ! which java
then
    # install oracle java
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install oracle-java7-installer -y
fi


