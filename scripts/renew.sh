#!/bin/bash

/usr/bin/certbot --manual -n -m $EMAIL --agree-tos --manual-auth-hook upload --manual-cleanup-hook clean --domains $DOMAIN --preferred-challenges http --manual-public-ip-logging-ok certonly
/usr/local/bin/finish
