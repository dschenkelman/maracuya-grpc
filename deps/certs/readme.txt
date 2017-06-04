https://gist.github.com/kyledrake/d7457a46a03d7408da31
http://users.skynet.be/pascalbotte/art/server-cert.htm
https://web.archive.org/web/20160403100211/https://metabrot.rocho.org/jan/selfsign.html

#!/bin/sh

# setup directory for certificate
mkdir $HITCH_CERT_DIR
openssl req -nodes -x509 -newkey rsa:4096 -keyout "$HITCH_CERT_DIR/maracuya.key" -out "$HITCH_CERT_DIR/maracuya.crt" -days 365 -subj "/CN=localhost"
cat "$HITCH_CERT_DIR/maracuya.key" "$HITCH_CERT_DIR/maracuya.crt" > "$HITCH_CERT_DIR/localhost.pem"

https://sergii.rocks/feed/post/nginx-http2-with-alpn-on-debian-8-jessie