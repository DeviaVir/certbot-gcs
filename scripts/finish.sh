#!/bin/bash

mkdir -p /etc/letsencrypt/certs
if [ -f /etc/letsencrypt/certs/dhparam.pem ]; then
   echo "Not regenerating dhparam.pem, already exists."
else
   /usr/bin/openssl dhparam -dsaparam -out /etc/letsencrypt/certs/dhparam.pem 4096
fi
(cd /etc/letsencrypt/live/$DOMAIN && ls -l cert.pem | sed -e 's/.* -> //' > cert.pem.link)
(cd /etc/letsencrypt/live/$DOMAIN && ls -l chain.pem | sed -e 's/.* -> //' > chain.pem.link)
(cd /etc/letsencrypt/live/$DOMAIN && ls -l fullchain.pem | sed -e 's/.* -> //' > fullchain.pem.link)
(cd /etc/letsencrypt/live/$DOMAIN && ls -l privkey.pem | sed -e 's/.* -> //' > privkey.pem.link)
/google-cloud-sdk/bin/gsutil -m cp -r /etc/letsencrypt gs://$GCS_PRIVATE_BUCKET
