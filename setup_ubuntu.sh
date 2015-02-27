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
if [ ! -d ~/bin ]
then
    mkdir ~/bin
fi

if [ ! -d ~/.ssh ]
then
	mkdir ~/.ssh
fi

# setup around ssh
if [ ! -f ~/.ssh/id_rsa ]
then
    ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa
fi

touch ~/.ssh/config ~/.ssh/authorized_keys
chmod 600 ~/.ssh/*

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


