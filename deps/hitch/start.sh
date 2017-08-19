#!/bin/sh
exec /usr/local/sbin/hitch \
  --backend=[localhost]:$MARACUYA_PORT --frontend=[*]:$HITCH_PORT \
  --alpn-protos="h2" \
  $HITCH_CERT_DIR/localhost.pem