#!/usr/bin/env bash
export CONTAINERIP=$(hostname -I | cut -f1 -d' ')

function deregister() {
    echo "Trapping exit"
    curl -X POST http://consul.service.consul:8500/v1/agent/service/deregister/redis-$HOSTNAME \
        --header 'Content-Type: application/json'
    kill -SIGTERM -1
}
trap "deregister" EXIT

# start app
/entrypoint.sh redis-server &

# register with consul
curl -X POST http://consul.service.consul:8500/v1/agent/service/register \
    --header 'Content-Type: application/json' \
    --data-binary '{"ID": "'"redis-$HOSTNAME"'", "Name": "redis", "Address": "'"$CONTAINERIP"'", "Port": 6379}'

while true; do :; done
