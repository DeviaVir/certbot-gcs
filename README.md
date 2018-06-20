# certbot-gcs

### Overview

I was looking for a way to have a cluster of machines on Google's (G)CE
running nginx frontends protected by letsencrypt. This project gets that job
done.

### Pre-requisites

- Letsencrypt domain
- Letsencrypt email
- Private GCS bucket (only accessible by instance's service account)
- Public GCS bucket (web-accessible)
- `/home/services` exists and is the user that is running the services

### Services

You can use the `.service` and `.timer` files in this repo as your systemd
units.


### nginx.conf

Make sure to mount `-v /home/services/certs:/etc/nginx/certs:ro` on your nginx
container. Then you can use the following blob in your nginx.conf:

```
listen 443 ssl;
ssl_certificate /etc/nginx/certs/live/your-letsencrypt-domain/fullchain.pem;
ssl_certificate_key /etc/nginx/certs/live/your-letsencrypt-domain/privkey.pem;

ssl_prefer_server_ciphers on;
ssl_dhparam /etc/nginx/certs/certs/dhparam.pem;
```
