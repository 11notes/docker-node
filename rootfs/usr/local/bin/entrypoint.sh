#!/bin/ash
if [ -z "$1" ]; then
    set -- "node" /node/main.js
else
    set -- "node" $1
fi

exec "$@"