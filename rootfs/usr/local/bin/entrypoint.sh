#!/bin/ash
  if [ -z "$1" ]; then
      set -- "node" /node/main.js
  fi

  exec "$@"