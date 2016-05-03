# rancher-secure
Rancher server served behind an nginx container only available on HTTPS

## Usage

1. Add SSL certificates key.pem and cert.pem to certs/ (which should be the full chained certificate including authority certificate)
2. Edit `server_name` in conf/default.conf to listen on the correct hostname.
3. Run `docker-compose up` with optional `-d`

## Additional Info

You can create free SSL certificates now using the letsencrypt service. To do so, run the below command:

```
docker run -it --rm -p 443:443 -p 80:80 --name letsencrypt -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" quay.io/letsencrypt/letsencrypt:latest auth
```

Then move the certificates created in /etc/letsencrypt/live (follow any symlinks) to the certs folder and rename as specified above.