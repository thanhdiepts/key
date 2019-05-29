#!/bin/sh
RESET='\033[0m'
GRAY='\033[0;37m'
WHITE='\033[1;37m'
RED='\033[1;31m' # Light Red.
GREEN='\033[1;32m' # Light Green.

clear
wget -O /tmp/ul https://raw.githubusercontent.com/goofball222/unifi/master/5.11/unstable/VERSION > /dev/null 2>&1
latest=`cat /tmp/ul`
current=`cat /usr/lib/unifi/version`
echo "$GREEN Phien ban UniFi Controller" $GRAY
echo "Hien tai:" $current $RED
echo "Moi nhat:" $latest  $RESET
if  [ $latest != $current ]
then
echo "$RED Stopping UniFi services..."
service unifi stop || abort
echo "$WHITE Downloading  latest UniFi"
cd /tmp
wget -O UniFi.zip https://dl.ubnt.com/unifi/$latest/UniFi.unix.zip || abort
unzip UniFi.zip
rm -rf /usr/lib/unifi/lib
rm -rf /usr/lib/unifi/webapps
rm -rf /usr/lib/unifi/logs
rm -rf /usr/lib/unifi/run
cd UniFi && cp -rf lib webapps  /usr/lib/unifi/
cd ..
rm -rf UniFi*
echo $latest > /usr/lib/unifi/version
chown -R unifi:unifi /usr/lib/unifi
fi
echo "$RESET"
service unifi start &
