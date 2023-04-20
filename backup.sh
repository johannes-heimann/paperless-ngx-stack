#!/bin/bash

# load config from .env
DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${DIR}/.env

# run paperless document exporter
docker compose -f ${DIR}/docker-compose.yml exec -T webserver document_exporter -na -nt -f --delete ../export

# use rsync to create a remote backup
 /usr/bin/sshpass -p "${SSH_BACKUP_PASS}" /usr/bin/rsync -avx --delete ${DIR}/export ${SSH_USERNAME}@${BACKUP_HOST}:${BACKUP_HOST_PATH}/
