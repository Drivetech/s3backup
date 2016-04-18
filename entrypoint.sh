#!/bin/sh

set +e

if [[ ${BACKUP_TIMEZONE} ]]; then
  # See http://wiki.alpinelinux.org/wiki/Setting_the_timezone
  cp /usr/share/zoneinfo/${BACKUP_TIMEZONE} /etc/localtime
  echo "${BACKUP_TIMEZONE}" >  /etc/timezone
fi

if [ -z ${BACKUP_CRON_SCHEDULE+x} ]; then
  /usr/local/bin/backup
else
  BACKUP_CRON_SCHEDULE=${BACKUP_CRON_SCHEDULE}
  echo "${BACKUP_CRON_SCHEDULE} /usr/local/bin/backup" > /etc/crontabs/root
  # Starting cron
  crond -f -d 0
fi
