#!/bin/sh
DOMAIN="cloud.vuitvt.com"
UNIFI="/usr/lib/unifi/data/keystore"
OMADA="/opt/Omada/keystore/eap.keystore"
SSL="/etc/letsencrypt/live"
PKCS="${SSL}/${DOMAIN}/fullchain.p12"
rm -f $OMADA $UNIFI

#eap
openssl pkcs12 -export -inkey ${SSL}/${DOMAIN}/privkey.pem -in ${SSL}/${DOMAIN}/fullchain.pem -out $PKCS -name unifi -password pass:unifi
keytool -importkeystore -storetype PKCS12 -destkeystore $UNIFI -srckeystore $PKCS -deststorepass aircontrolenterprise -destkeypass aircontrolenterprise -srcstoretype PKCS12 -srcstorepass unifi -alias unifi -noprompt

#omada
openssl pkcs12 -export -inkey ${SSL}/${DOMAIN}/privkey.pem -in ${SSL}/${DOMAIN}/fullchain.pem -out $PKCS -name tplink -password pass:tplink
keytool -importkeystore -storetype PKCS12 -destkeystore $OMADA -srckeystore $PKCS -destkeypass tplink -deststorepass tplink -srcstoretype PKCS12 -srcstorepass tplink -alias tplink -noprompt


#service unifi restart && service Omada restart
