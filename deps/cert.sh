#!/bin/sh

# setup directory for certificate
mkdir $HITCH_CERT_DIR
openssl req -nodes -x509 -newkey rsa:4096 -keyout "$HITCH_CERT_DIR/maracuya.key" -out "$HITCH_CERT_DIR/maracuya.crt" -days 365 -subj "/CN=localhost"
cat "$HITCH_CERT_DIR/maracuya.key" "$HITCH_CERT_DIR/maracuya.crt" > "$HITCH_CERT_DIR/maracuya.pem"
