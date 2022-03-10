#!/bin/bash

mkdir -p /var/log/tor/
chown tor:tor /var/log/tor
touch /var/log/tor/notices.log
chown tor:tor /var/log/tor/notices.log

if [ ! -f /app/etc/torrc ]; then 
    echo "cp torrc"
    cp /torrc /app/etc/torrc.sample;
    cp /torrc /app/etc/torrc;
    cp /app/etc/torrc /etc/tor/torrc;
    su-exec tor tor
else 
    echo "run userRun.sh"
    cp /app/etc/torrc /etc/tor/torrc;
    su-exec tor tor
fi