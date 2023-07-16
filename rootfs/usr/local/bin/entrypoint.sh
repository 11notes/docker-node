#!/bin/ash
  if [ -z "$1" ]; then
    set -- "node" ${APP_ROOT}/app.js
  fi

  exec "$@"