# s3backup

[![Docker Stars](https://img.shields.io/docker/stars/lgatica/s3backup.svg?style=flat-square)](https://hub.docker.com/r/lgatica/s3backup)
[![Docker Pulls](https://img.shields.io/docker/pulls/lgatica/s3backup.svg?style=flat-square)](https://hub.docker.com/r/lgatica/s3backup/)
[![Image Size](https://img.shields.io/imagelayers/image-size/lgatica/s3backup/latest.svg?style=flat-square)](https://imagelayers.io/?images=lgatica/s3backup:latest)
[![Image Layers](https://img.shields.io/imagelayers/layers/lgatica/s3backup/latest.svg?style=flat-square)](https://imagelayers.io/?images=lgatica/s3backup:latest)

Docker Image with [Alpine Linux](http://www.alpinelinux.org) and [s3cmd](http://s3tools.org/s3cmd) for backups to s3

## Use

### Periodic backup

Run every day at 2 am

```bash
docker run -d --name backup \
  -v /path/to/source:/backup/input \
  -e "BACKUP_AWS_KEY=your_aws_key"
  -e "BACKUP_AWS_SECRET=your_aws_secret"
  -e "BACKUP_AWS_S3_PATH=s3://your_bucket" \
  -e "BACKUP_TIMEZONE=America/Santiago" \
  -e "BACKUP_CRON_SCHEDULE=0 2 * * *"
  lgatica/s3backup
```

### Inmediatic backup

```bash
docker run --rm \
  -v /path/to/source:/backup/input \
  -e "BACKUP_AWS_KEY=your_aws_key"
  -e "BACKUP_AWS_SECRET=your_aws_secret"
  -e "BACKUP_AWS_S3_PATH=s3://your_bucket" \
  lgatica/s3backup
```

## IAM Policity

You need to add a user with the following policies. Be sure to change `your_bucket` by the correct.

```xml
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1412062044000",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl"
            ],
            "Resource": [
                "arn:aws:s3:::your_bucket/*"
            ]
        },
        {
            "Sid": "Stmt1412062128000",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::your_bucket"
            ]
        }
    ]
}
```

## Configuration

- `BACKUP_PREFIX` - Default value is `backup`. Example `backup.2016-04-18T20-40-00+0000.tar.gz
- `BACKUP_AWS_KEY` - AWS Key.
- `BACKUP_AWS_SECRET` - AWS Secret.
- `BACKUP_AWS_S3_PATH` - path to S3 bucket, like `s3://your_bucket`.
- `BACKUP_TIMEZONE` - change timezone from UTC to
    [tz database](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones),
    for example `America/Santiago`. Defaults to empty.
- `BACKUP_CRON_SCHEDULE` - specify when and how often you want to run backup
    script. Example `0 2 * * *` (every day at 2am). Default is empty, that is executed immediately.
