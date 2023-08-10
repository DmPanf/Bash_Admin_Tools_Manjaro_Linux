#!/bin/bash
#
# Installation script for VirtualBox in Debian 8 Jessie & Debian 7 Wheezy

date
echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update -y
sudo apt-get install virtualbox-5.0 -y
date
