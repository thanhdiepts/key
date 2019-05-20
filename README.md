
nmcli connection modify eth0 ipv4.addresses 192.168.1.254/24 ipv4.gateway 192.168.1.1 && nmcli connection down eth0 && nmcli conn up eth0

cat > /usr/sbin/checkwlan.sh <<EOF
#!/bin/sh
wlan=`ifconfig wlan0 | grep inet | wc -l`
if [ $wlan -eq 0 ]; then
    nmcli con down wlan0 && nmcli con up wlan0
else
    echo interface is up
fi
EOF
