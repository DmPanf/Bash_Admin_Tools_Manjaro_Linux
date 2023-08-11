#!/bin/bash
# 22-04-2021 Send Alarm Message in Cases of SSH-Connection to Bot [MOI INSTRUMENT]
# STANDART: /etc/ssh/sshrc -> ~/scr/login_ssh.sh

myINFO="/etc/ssh/zInfo.0"
iUser=$(cat $myINFO | grep -v "#" | grep User= | cut -d"=" -f2)
iDir="/home/$iUser"

myTask="alarm"
myLog1="$iDir/scr/.zLog/.${myTask}.log"
if ! [ -f $myLog1 ]; then
  mkdir $iDir/scr/.zLog
  echo "" > $myLog1
fi

TOKEN=$(cat $myINFO | grep -v "#" | grep TOKEN2= | cut -d"=" -f2)
CHAT_ID=$(cat $myINFO | grep -v "#" | grep CHAT_ID2= | cut -d"=" -f2)
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

myIcon=$(cat $myINFO | grep -v "#" | grep Icon= | cut -d"=" -f2)
myName=$(cat $myINFO | grep -v "#" | grep Name= | cut -d"=" -f2)
iPC="$myIcon$myName"

#xIP=$(echo $SSH_CONNECTION | cut -d" " -f 1)
xIP=$(echo $SSH_CONNECTION)
#logger -t ssh-wrapper $USER login from $xIP
myTime=$(date +%d-%m_%H:%M:%S)
echo "⚠️ $myTime $iPC $SSH_TTY $USER $xIP" >> $myLog1
iSMS=$(cat $myLog1 | tail -1)

/usr/bin/curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$iSMS" > /dev/null

exit 0
