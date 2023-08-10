#!/bin/bash
# Script for short PC INFO
# info.sh
echo ""
IP=$(/sbin/ifconfig | grep inet | grep -v inet6 | grep -v 127.0.0.1 | cut -d: -f2 | awk '{printf $1" "}')
Lan=$(/sbin/ifconfig | grep HWaddr | grep -v wlan | cut -d" " -f1)
Speed=$(sudo /sbin/ethtool $Lan | grep Speed | cut -d":" -f2)
MAC=$(/sbin/ifconfig | grep HWaddr | cut -d" " -f11)
Wan=$(wget -O - -q icanhazip.com)
myCPU=$(cat /proc/cpuinfo | grep 'name' | wc -l)
nameCPU=$(cat /proc/cpuinfo | grep 'name' | uniq)
mySSH=""
if [ -e /etc/ssh/sshd_config ]; then mySSH="; SSH: $(cat /etc/ssh/sshd_config | grep Port)"; fi
mySys="$(uname -m) $(uname -o) $(uname -r) $(lsb_release -i) $(lsb_release -r) $(lsb_release -c)"
myDNS=$(cat /etc/resolv.conf |grep nameserver)

echo "========================================================================================="
dmesg | tail # ==> Вывод последних строк системы
echo "========================================================================================="
df -hT | grep -v 'none' # ==> Вывод размеров файловых систем
echo "========================================================================================="
free # ==> Память системы
echo "========================================================================================="
echo `sensors|grep Core| cut -b 1-25` # Вывод температуры процессора
for word in $(ls -al /dev/sd* | cut -d/ -f3 | cut -b 1-3 | uniq) ; do
        MyDisk=$(sudo fdisk -l /dev/$word 2>/dev/null | grep 'Диск /dev/')
	if [ "$MyDisk" = "" ] ; then MyDisk=$(sudo fdisk -l /dev/$word 2>/dev/null | grep 'Disk /dev/') ; fi
        if [ "$MyDisk" != "" ] ; then echo "++++ $MyDisk  ["$(sudo hddtemp /dev/$word 2>/dev/null)"]" ; fi
done # ==> Вывели размеры и температура дисков
echo "========================================================================================="
if [ -e /sbin/mdadm ] ; then
        sudo fdisk -l /dev/$(cat /proc/mdstat | grep 'md' | cut -d" " -f1) 2>/dev/null | grep 'Диск'
        sudo /sbin/mdadm --detail --scan --verbose 2>/dev/null
        cat /proc/mdstat
        echo "========================================================================================="
fi # ===> Вывод инфо о дисковых массивах (если есть)
if [ -e /sbin/lvmdiskscan ]; then
	sudo /sbin/lvmdiskscan
	echo "========================================================================================="
fi # ===> Вывод инфо о разделах дисков и LVM
echo "" # ==> Далее сжатая выборочная информация о системе:
echo $(date +%Y-%m-%d)
echo -en "\033[1;31m" # включить красное выделение
echo "**** PC Name: $(uname -n); User: $(whoami) $mySSH"
echo -en "\033[0m" # вернуть все цвета обратно
echo "++++ $mySys"
echo "++++ CPU x $myCPU [$nameCPU]"
echo "++++ $Lan =$Speed [$MAC] ==> LAN: $IP  WAN: $Wan"
echo "$myDNS"
echo ""
echo "Now: $(uptime)"
echo "Login users:"
echo "$(who)"
echo `pwd`
echo ""
