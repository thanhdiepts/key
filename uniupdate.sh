#!/bin/sh
RESET='\033[0m'
GRAY='\033[0;37m'
WHITE='\033[1;37m'
RED='\033[1;31m' # Light Red.
GREEN='\033[1;32m' # Light Green.

clear
echo "${GREEN}Cap nhat APT Repo... vui long doi trong giay lat"
apt-get update > /dev/nul || abort
apt-cache policy unifi > /tmp/ucache || abort
sed -n '2,2p' /tmp/ucache > /tmp/uc || abort
sed -n '3,3p' /tmp/ucache > /tmp/ul || abort
current=`cat /tmp/uc | awk -F' '  '{print $2}' | awk -F'-'  '{print $1}')`
latest=`cat /tmp/ul | awk -F' '  '{print $2}' | awk -F'-'  '{print $1}')`
echo "Phien ban UniFi Controller" $GRAY
echo "Hien tai:" $current $RED
echo "Moi nhat:" $latest  $RESET
if  [ $latest != $current ]
then
service unifi stop || abort
cd /tmp
#wget -O UniFi.zip https://dl.ubnt.com/unifi/5.11.10-35d70ccf84/UniFi.unix.zip
#unzip UniFi.zip
#rm -rf /usr/lib/unifi/lib
#rm -rf /usr/lib/unifi/webapps
#rm -rf /usr/lib/unifi/logs
#rm -rf /usr/lib/unifi/run
#cd UniFi && cp -rf lib webapps conf /usr/lib/unifi/
#cd ..
#rm -rf UniFi*
wget https://dl.ubnt.com/unifi/$latest/unifi_sysvinit_all.deb
dpkg -i unifi_sysvinit_all.deb
chown -R unifi:unifi /usr/lib/unifi/
echo $latest > /usr/lib/unifi/version
rm unifi_sysvinit_all.deb
fi
service unifi start &
