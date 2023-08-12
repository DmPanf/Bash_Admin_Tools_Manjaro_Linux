#!/bin/bash
# 31-12-2022
# /home/bunta/scr/00_wake_bot.sh
# [Cron] @reboot sleep 30 && /bin/bash /home/bunta/scr/00_wake_bot.sh > /dev/null 2>&1

myName="🆚1️⃣ v1538083"
myPlace="🔎VDSina.RU"
TOKEN=508396183:AAHwIxS3TRvMiTNoo5h0MXla5rFYoEdR2g4
CHAT_ID1=XXX # Dm

#Port=$(cat /home/bunta/scr/01_auto_ssh.sh | grep myPort= | cut -d"=" -f2)
Port='XXX'
LAN=$(hostname -I)
#WAN=$(wget -qO- ipinfo.io/ip)
myOS=$(hostnamectl | grep System | cut -d ":" -f2)
#myTemp=$(vcgencmd measure_temp | cut -c 6-)
myRAM='®️ 1 GB @ 2.992GHz'
myHome=$(/bin/df -Th /home 2>/dev/null | tail -n 1)
sFull=$(echo $myHome | awk '{print $3 }')
pUse=$(echo $myHome | awk '{print $6 }')
sFree=$(echo $myHome | awk '{print $5 }')
iPort=$(echo $Port | tr -d \") # избавляемся от кавычек

#MESSAGE="$myName🌡$myTemp [$LAN/ $WAN/] $myOS 📀 $sFull-$pUse=$sFree free $myPlace▫️$iPort"
MESSAGE="$myName $myRAM [$LAN/] $myOS 📀 $sFull-$pUse=$sFree free $myPlace▫️$iPort"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"
#MyStr="/usr/bin/curl -s -X POST $URL -d chat_id=$CHAT_ID -d text=\"$MESSAGE\""

/usr/bin/curl -s -X POST $URL -d chat_id=$CHAT_ID1 -d text="$MESSAGE"

exit 0
