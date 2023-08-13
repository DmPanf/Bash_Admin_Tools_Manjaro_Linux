#!/bin/bash
# Скрипт Reboot проверяет состояние параметров каждую минуту
# ... в случае, если "1️⃣ есть команда на перезапуск" или "2️⃣ зависла сеть" и время работы системы "более 15 мин"
# /home/pi/scr/02-reboot.sh
# * * * * * /bin/bash /home/pi/scr/02_reboot.sh # "crontab -e"
# "💾 Info to Check & Change 💾":

myTask="reboot"
myPC="web0"
myPort="XXX"
myIP="user@XXX"
myKey="/home/$(whoami)/.ssh/id_rsa.web0"

### ======= Прочие Значения
myLog1="$HOME/scr/.${myTask}_task.log"
web0_path="/home/pi/ARCHIVE/MyKeys.000/${myPC}/${myTask}.d"
Task0="cat ${web0_path}"
Task2="cat > /home/pi/ARCHIVE/MyKeys.000/${myPC}/${myTask}.d"
# ssh -q -p XXXX user@XXX -i /home/$(whoami)/.ssh/id_rsa.web0 "cat /home/pi/ARCHIVE/MyKeys.000/kino1/reboot.d" 2> /dev/null
myCode=$(ssh -q -p $myPort $myIP -i $myKey $Task0 2> /dev/null)
myTime=$(date +%Y-%m-%d_%H:%M)

if [ "$myCode" == "010" ]
then   # передаем файл данных и записываем обратно значение вместо [010] -> [Time]
  my_sh2=$(echo "$myTime" | ssh -q -p $myPort $myIP -i $myKey $Task2 2> /dev/null) # Запись времени в reboot.d
  echo "$myTime ** $(hostname -I) ** CPU Load: $(uptime | awk '{print $9}') за 5 мин" >> $myLog1
  sudo reboot   # все действия фиксируем в log-файле и ПЕРЕЗАПУСК RasPi от имени пользователя, ибо см. [/etc/sudoers]
fi

exit 0
