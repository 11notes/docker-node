#!/bin/ash
  if [ -z "${1}" ]; then
    if [ -f "${APP_ROOT}/package.json" ]; then
      npm install
      set -- npm start
    else
      if [ -f "${APP_ROOT}/main.js" ]; then
        set -- "node" ${APP_ROOT}/main.js
      fi
    fi
  fi

  exec "$@"