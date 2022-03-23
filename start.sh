#!/bin/sh
docker run -d \
    -p 9090:9090 \
    --name vouch-proxy \
    -v ${PWD}/config:/config \
    quay.io/vouch/vouch-proxy

