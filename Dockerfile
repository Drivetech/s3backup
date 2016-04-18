FROM alpine:latest

MAINTAINER Leonardo Gatica <lgatica@protonmail.com>

RUN apk add --no-cache python py-pip ca-certificates tzdata \
    && pip install --upgrade pip \
    && pip install s3cmd \
    && rm -fR /etc/periodic

COPY backup /usr/local/bin/
RUN chmod +x /usr/local/bin/backup

COPY s3cfg /root/.s3cfg
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh

CMD /sbin/entrypoint.sh
