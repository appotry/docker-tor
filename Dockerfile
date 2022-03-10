FROM alpine:latest

LABEL maintainer="appotry <andycrusoe@gmail.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}

RUN apk upgrade --update \
    && apk add tor privoxy bash tzdata su-exec \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && rm -rf /var/cache/apk/*
#    && ln -sf /dev/stdout /var/log/tor/notices.log \

#COPY torrc /etc/tor/torrc
COPY torrc /torrc

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /*.sh

CMD ["/entrypoint.sh"]
