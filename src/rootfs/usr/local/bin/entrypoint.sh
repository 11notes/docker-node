#!/bin/ash
  if [ -z "${1}" ]; then
    if [ -f "${APP_ROOT}/package.json" ]; then
      eleven log INFO "found package.json, issuing npm start"
      cd ${APP_ROOT}
      npm install
      set -- npm start
    else
      if [ -f "${APP_ROOT}/main.js" ]; then
        eleven log INFO "found main.js, issuing node start"
        set -- "node" ${APP_ROOT}/main.js
      fi
    fi
  fi

  exec "$@"