#!/bin/bash
# 25-05-2021 miniDLAN Install Script ver.2.0
# ~/scr/kino2_config.sh
# Скорректировать путь к доп.папке с Видео
fDOP="/mnt/SSD/iKINO"

if [ -d "$fDOP" ]; then
 iVideoDop="media_dir=V,$fDOP/"
else
 iVideoDop="#"
fi

fDLNA="/etc/minidlna.conf"
myScr="$HOME/ARCHIVE/scripts"
myDate=$(date +%d-%m-%Y)
iYear=$(date +%Y)

iDLNA=`cat <<_EOF_

port=8200
notify_interval=120
db_dir=/var/cache/minidlna
log_dir=/var/log
inotify=yes
#
album_art_names=AlbumArt.jpg/albumart.jpg/Album.jpg/album.jpg
album_art_names=Cover.jpg/cover.jpg/AlbumArtSmall.jpg/albumartsmall.jpg
album_art_names=Folder.jpg/folder.jpg/Thumb.jpg/thumb.jpg
#
_EOF_`

iDate="#$myDate [ver.2.0]"
iName="friendly_name=iKINO-$iYear"
iMusic="#media_dir=A,$HOME/iMusic/"
iFOTO="#media_dir=P,$HOME/iFOTO/"
iVideo="media_dir=V,$HOME/MOSCOW/Video/"

echo " ..... miniDLNA =>"
if ! [ -f /etc/minidlna.conf ]; then
 sudo apt update
 sudo apt install minidlna -y
 sudo service minidlna stop
 sudo mv "$fDLNA" "$fDLNA.old"
 echo "$iDate" > ./temp.1
 echo "$iDLNA" >> ./temp.1
 echo "$iName" >> ./temp.1
 echo "$iMusic" >> ./temp.1
 echo "$iFOTO" >> ./temp.1
 echo "$iVideo" >> ./temp.1
 echo "$iVideoDop" >> ./temp.1
 sudo mv ./temp.1 "$fDLNA"
fi

echo " ..... Links to Moscow =>"
if ! [ -d $HOME/MOSCOW ]; then
 mkdir $HOME/MOSCOW/
 ln -s $HOME/MOSCOW/Video $HOME/iKino
 ln -s $HOME/MOSCOW/Music $HOME/iMusic
 ln -s $HOME/MOSCOW/Pictures $HOME/iFOTO
fi

echo " ..... New Scripts =>"
if ! [ -d  $myScr ]; then
 mkdir -p $myScr
fi

echo " ..... SSHFS =>"
if ! [ -d  /mnt/FUSE ]; then
 sudo mkdir -p /mnt/FUSE
 sudo chown $(whoami): /mnt/FUSE/ -R
 ln -s /mnt/FUSE/ $HOME/USB
 sudo apt-get install sshfs -y
 sudo groupadd fuse
 sudo adduser $(whoami) fuse
 sudo chown root:fuse /dev/fuse
 echo 'user_allow_other' | sudo tee --append /etc/fuse.conf > /dev/null
fi

if ! [ -f $myScr/fig/06_start_kino.sh ]; then
 echo "#!/bin/bash" > $myScr/my_kino.sh
 echo "#$myDate [ver.1.0]" >> $myScr/my_kino.sh
 echo "# Пишем скрипт для подключения...." >> $myScr/my_kino.sh
 nano $myScr/my_kino.sh && /bin/bash $myScr/my_kino.sh
else 
 /bin/bash $HOME/scr/fig/06_start_kino.sh
fi

sudo service minidlna start
echo "OK! $myDate"
echo ""
echo "sudo service minidlna status"
sudo service minidlna status
exit 0
