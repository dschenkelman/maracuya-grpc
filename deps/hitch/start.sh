#!/bin/sh
exec /usr/local/sbin/hitch \
  --backend=[localhost]:$MARACUYA_PORT --frontend=[*]:4433 \
  --alpn-protos="h2" \
  $HITCH_CERT_DIR/localhost.pem