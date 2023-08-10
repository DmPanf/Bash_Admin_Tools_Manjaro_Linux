#!/bin/bash
#
# alias mnt.fuse='sshfs -p 2117 bunta@83.136.233.30:/home/bunta/ /mnt/FUSE'
# fusermount -u /mnt/FUSE

if [ ! -e /mnt/FUSE ] 
then
 sudo apt-get install sshfs -y
 sudo mkdir /mnt/FUSE
 sudo chown bunta:bunta /mnt/FUSE/ -R
 ln -s /mnt/FUSE/ $HOME/FUSE
 sudo adduser bunta fuse
 sudo chown root:fuse /dev/fuse
 MyAdd1="alias mnt.fuse='sshfs -p 2117 bunta@83.136.233.30:/home/bunta/ /mnt/FUSE'"
 MyAdd2="alias umnt.fuse='fusermount -u /mnt/FUSE'"
 echo $MyAdd1  >> $HOME/.bash_aliases
 echo $MyAdd2  >> $HOME/.bash_aliases
 echo ""
 echo "OK! Please reboot."
else
 echo ""
 echo ".../mnt/FUSE exists!"
fi
