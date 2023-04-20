# Paperless Docker Stack

Paperless-ngx stack with NGINX reverse-proxy, DuckDNS, Certbot and FTP server.

## Run

Fill in the information in the `.env.example` file, rename it to `.env` and run `docker compose up -d`.

## Paperless

#### Create User

`docker compose run --rm webserver createsuperuser`

#### Backup

Run the `bachup.sh` script or create a manual Backup: (only changes)

`docker compose exec -T webserver document_exporter -na -nt -f --delete ../export`

Sync `export`-Folder (e.g. with `crontab`):

` /usr/bin/sshpass -p 'password' /usr/bin/rsync -avx --delete [path]/paperless/export [username]@[host]:/[path]/`

Import Backup and re-generate Thumbnails + PDF/A documents:

- `docker compose exec -T webserver document_importer ../export`
- `docker compose exec -T webserver document_thumbnails`
- `docker compose exec -T webserver document_archiver --overwrite`

## Certbot

- `docker compose run -p 80:80 --rm certbot certonly --standalone --preferred-challenges http --dry-run -d [subdomain].duckdns.org`
- `docker compose run --rm certbot renew`


## Links / Credit

- Paperless-ngx: `https://docs.paperless-ngx.com/`
- DuckDNS: `https://www.duckdns.org/`
- Certbot guide: `https://mindsers.blog/post/https-using-nginx-certbot-docker/`