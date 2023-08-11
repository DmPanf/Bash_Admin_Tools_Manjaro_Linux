#!/bin/bash
# 19-04-2021 Script to Check All SSH-Connections & Established Ports
w1="🈴 Web1=..."
w2="☣️ Web2=..."
w3="💾Web3=..."
w4="🏡Web4=..."
w5="🌎Web5=..."
b=$(tput bold)
c0="\E[0;39m"   # c_std
cG="\E[1;32m"   # c_h_green
cZ="${b}\E[44m" # Zagolovok
echo -e ${b}${cG}"\nPC:  $w1 $w2 $w3 $w4 $w5"${c0}
echo -e ${cZ}"===== w ====="${c0}
w
echo -e ${cZ}"\n===== ps -fC ssh ====="${c0}${cG}
ps -fC ssh
echo -e ${c0}${cZ}"\n===== sudo lsof -i | egrep '\<ssh\>' | grep -v 'LISTEN' ====="${c0}${cG}
sudo lsof -i | egrep '\<ssh\>' | grep -v "LISTEN"
echo -e ${c0}${cZ}"\n===== ss -o state established '( dport = :ssh or sport = :ssh )' ====="${c0}
ss -o state established '( dport = :ssh or sport = :ssh )'
echo -e ${cZ}"\n===== sudo netstat -ntlp | grep -v 'tcp6' ====="${c0}
sudo netstat -ntlp | grep -v "tcp6"
echo -e ""${c0}
