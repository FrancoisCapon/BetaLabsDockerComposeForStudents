#!/usr/bin/env sh

killall --quiet lighttpd
lighttpd -f lighttpd.conf
ss -ltrpn

