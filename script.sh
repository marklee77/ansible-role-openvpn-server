#!/bin/sh
mkdir -p ssl/certs ssl/private

export KEY_DIR=ssl
export KEY_SIZE=2048

export KEY_COUNTRY=""
export KEY_PROVINCE=""
export KEY_CITY=""
export KEY_ORG=""
export KEY_EMAIL=""
export KEY_OU=""
export KEY_NAME=""
export PKCS11_MODULE_PATH=""
export PKCS11_PIN=""

export KEY_ALTNAMES="Test CA"
export KEY_CN="Test CA"
openssl req -new -newkey rsa:2048 -x509 -nodes -days 3650 -subj "/CN=Test CA" \
    -out ssl/certs/ca.crt -keyout ssl/private/ca.key \
    -config /usr/share/easy-rsa/openssl-1.0.0.cnf 

export KEY_ALTNAMES="DNS:localhost"
export KEY_CN="localhost"
openssl req -new -newkey rsa:2048 -nodes -days 3650 -subj "/CN=localhost" \
    -keyout ssl/private/server.key \
    -extensions server \
    -config /usr/share/easy-rsa/openssl-1.0.0.cnf |\
    openssl x509 -req -CA ssl/certs/ca.crt -CAkey ssl/private/ca.key \
        -out ssl/certs/server.crt -CAcreateserial \
        -extensions server \
        -extfile /usr/share/easy-rsa/openssl-1.0.0.cnf
