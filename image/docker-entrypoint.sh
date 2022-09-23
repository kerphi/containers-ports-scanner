#!/bin/bash

#/usr/share/nginx/html/
#CPS_SERVERS_TO_SCAN

/do-scan-containers-ports.sh > /usr/share/nginx/html/index.html

# execute nginx (cf CMD dans Dockerfile)
exec "$@"
