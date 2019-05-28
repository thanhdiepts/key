#!/bin/sh
echo "1. Stop UniFi service"
service unifi stop || abort
echo "2. Modify UniFi properties configuration"
sed -i 's/is_default=false/is_default=true/g' /usr/lib/unifi/data/system.properties || abort
#sed -i '/reporter-uuid/d' /usr/lib/unifi/data/system.properties || abort
sed -i '/uuid/d' /usr/lib/unifi/data/system.properties || abort
echo "3. Starting UniFi"
service unifi start || abort
echo "Done"
