#!/bin/bash

/google-cloud-sdk/bin/gsutil -m cp -r gs://$GCS_PRIVATE_BUCKET/letsencrypt/ /etc/
(cd /etc/letsencrypt/live/$DOMAIN && ln -sf "$(< chain.pem.link)" chain.pem)
(cd /etc/letsencrypt/live/$DOMAIN && ln -sf "$(< fullchain.pem.link)" fullchain.pem)
(cd /etc/letsencrypt/live/$DOMAIN && ln -sf "$(< cert.pem.link)" cert.pem)
(cd /etc/letsencrypt/live/$DOMAIN && ln -sf "$(< privkey.pem.link)" privkey.pem)
