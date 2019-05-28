#!/bin/sh
echo "1. Stop Omada service"
service Omada stop  || abort
#sed -i 's/is_default=false/is_default=true/g' /usr/lib/unifi/data/system.properties || abort
#sed -i '/reporter-uuid/d' /usr/lib/unifi/data/system.properties || abort
#sed -i '/uuid/d' /usr/lib/unifi/data/system.properties || abort
echo "2. Remove old database and logs"
rm -rf /opt/Omada/data/db/* || abort
rm -rf /opt/Omada/logs/* || abort
echo "3. Start Omada"
service Omada start &
exit
