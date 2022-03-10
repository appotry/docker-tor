#!/bin/bash

#mkdir -p /var/log/tor/
#chown tor:tor /var/log/tor
#touch /var/log/tor/notices.log
chown tor:nogroup /var/log/tor/notices.log
ls -alh /var/log/tor/notices.log
ls -alh /var/log/tor

if [ ! -f /app/etc/torrc ]; then 
    echo "cp torrc and run"
    cp /torrc /app/etc/torrc.sample;
    cp /torrc /app/etc/torrc;
    cp /app/etc/torrc /etc/tor/torrc;
    su-exec tor tor
else 
    echo "run tor"
    cp /app/etc/torrc /etc/tor/torrc;
    su-exec tor tor
fi