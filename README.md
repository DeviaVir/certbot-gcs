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

Make sure to redirect traffic going to `http` to your web-accessible GCS bucket:
```
location /.well-known {
        auth_basic off;
        allow all; # Allow all to see content
        proxy_pass https://storage.googleapis.com/your-public-gcs-bucket/certs/.well-known;
}
```

It makes most sense to have separate nginx containers for port 80 and 443. This
way your port 80 nginx can still respond to requests (e.g. from letsencrypt)
while the 443 container might have problems with the certificates and hence
fails to start entirely.

Make sure to mount `-v /home/services/certs:/etc/nginx/certs:ro` on your nginx
container. Then you can use the following blob in your nginx.conf:

```
listen 443 ssl;
ssl_certificate /etc/nginx/certs/live/your-letsencrypt-domain/fullchain.pem;
ssl_certificate_key /etc/nginx/certs/live/your-letsencrypt-domain/privkey.pem;

ssl_prefer_server_ciphers on;
ssl_dhparam /etc/nginx/certs/certs/dhparam.pem;
```
