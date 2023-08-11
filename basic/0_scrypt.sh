#!/bin/bash
# My 0.Start Install Scrypt for RasPi or Linux [ver1.0 2019-11-19]
d_scr="$HOME/ARCHIVE/scripts/"
f_bash="$HOME/.bash_aliases"
my_date=$(date '+%Y-%m-%d %H:%M')
 
if [ ! -e $d_scr ] ; then mkdir -p $d_scr && ln -s $d_scr $HOME/scr; fi
if [ ! -e $HOME/.ssh ] ; then mkdir $HOME/.ssh && chmod 700 $HOME/.ssh -R; fi
if [ ! -e $f_bash ]
then
  echo "# $my_date [ver1.0]" > $f_bash
  echo "alias nnao='nano'" >> $f_bash
  echo "alias my.ssh='ps -ef | grep [s]sh && date'" >> $f_bash
  echo "alias sh.web3='ssh -C -p XXXX pi@X.X.X.X'" >> $f_bash
  echo "alias my.temp='vcgencmd measure_temp && cd /sys/bus/w1/devices && for grad in `ls | grep '28-'`; do echo $grad && cat ./$grad/w1_slave; done && cd -'" >> $f_bash
  echo "alias n.alias='sudo nano $HOME/.bash_aliases && . $HOME/.bashrc && date'" >> $f_bash
  echo "alias uu='sudo apt-get update -y && sudo apt-get upgrade -y'" >> $f_bash
  echo "alias my.ip='wget -O - -q icanhazip.com'" >> $f_bash
  echo "alias ver='/bin/bash $HOME/scr/board_version.sh && /bin/bash $HOME/scr/info.sh'" >> $f_bash
  echo "#" >> $f_bash
fi
. $HOME/.bashrc
 
mv $HOME/0_scrypt.sh $d_scr
cd $d_scr 
touch my_scrypt.sh board_version.sh info.sh
ls -al && date
