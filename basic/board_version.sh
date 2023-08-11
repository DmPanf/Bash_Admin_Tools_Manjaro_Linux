#!/bin/bash
# Вывод краткой информации для таблицы ARM-devices
if [ ! -e /usr/bin/lshw ] ; then sudo apt-get install lshw -y; fi
if [ ! -e /usr/bin/inxi ] ; then sudo apt-get install inxi -y; fi
date && echo "*****" && echo "" && sudo lshw -short | grep system
echo "CPU Serial:" && cat /proc/cpuinfo | grep Serial
echo "MAC-address:" && ip a | grep ether
echo "HW Revision Code:" && cat /proc/cpuinfo | grep Revision
echo "MicroSD Free:" && df -h | grep /dev/root
echo "" && vcgencmd measure_temp
echo "" && free
echo && sudo inxi -F
