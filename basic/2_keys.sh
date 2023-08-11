#!/bin/bash
# 17-02-2021 ~/.ssh/0_keys.sh
# Скрипт генерации ключей для Сервера OpenSSH [id_ed25519] и проверки работы SSH
# ssh-keygen -t ed25519 -f ./id_ed25519.$(hostname) -N "" -q

jDir="$HOME/.ssh"
iType="-t ed25519"
iName="id_ed25519.$(hostname)"

# Проверка существования каталога [$HOME/.ssh] = иначе его создание
if ! [ -e $jDir ]
then
  mkdir $jDir
  chmod 700 -R $jDir
fi
cd $jDir

# Автоматическая генерация ключей [id_ed25519] без пароля для секретного ключа и без вывода информации
ssh-keygen $iType -f $jDir/$iName -N "" -q

#cat $jDir/$iName.pub > $jDir/authorized_keys # Обнуляем файл только для доступа по новым ключам
cat $jDir/$iName.pub >> $jDir/authorized_keys
chmod 600 $jDir/authorized_keys

if ! [ -e $jDir/authorized_keys2 ]
then
  ln $jDir/authorized_keys $jDir/authorized_keys2
fi

echo ""
echo "💽 Публичный ключ записан в файл [authorized_keys] для доступа на этот Сервер!"
echo ""
cat $jDir/$iName.pub && rm $jDir/$iName.pub # Вывести на экран публичный ключ и удалить
echo ""
echo "💾 Необходимо записать секретный ключ на стороне Клиента:"
echo ""
cat $jDir/$iName && rm $jDir/$iName # Вывести на экран секретный ключ и удалить
echo ""
ls -alh $jDir
