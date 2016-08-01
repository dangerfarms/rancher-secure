# rancher-secure
Rancher server served behind an nginx container only available on HTTPS

## Usage

1. Add SSL certificates key.pem and cert.pem to certs/ (which should be the full chained certificate including authority certificate)
2. Edit `server_name` in conf/default.conf to listen on the correct hostname.
3. Run `docker-compose up` with optional `-d`

## Additional Info

You can create free SSL certificates now using the letsencrypt service. To do so, run the below commands. You'll be
asked to create certificates for a list of hostnames, you must ensure that DNS records have been set up that point to
the machine you are creating the certificates on.

Use the temporary webserver and follow the instructions.

```
DOMAIN=[whatever domain you are creating a certificate for]
docker run -it --rm -p 443:443 -p 80:80 \
  --name certbot \
  -v "$(pwd)/letsencrypt/etc:/etc/letsencrypt" \
  -v "$(pwd)/letsencrypt/var/lib/:/var/lib/letsencrypt" \
  quay.io/letsencrypt/letsencrypt:latest certonly;
sudo chown -R $USER:$USER letsencrypt;
mkdir -p certs;
cp -L letsencrypt/etc/live/$DOMAIN/* certs/;

# You are then free to remove the letsencrypt directory
rm -rf letsencrypt;

# Replace hostname (optional step if not done before)
sed -i.bak -e "s/{HOSTNAME}/$DOMAIN/g" conf.d/default.conf;
rm conf.d/default.conf.bak;
```
