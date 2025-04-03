# :: Util
  FROM alpine AS util

  RUN set -ex; \
    apk add --no-cache \
      git; \
    git clone https://github.com/11notes/docker-util.git; \
    cp -R /docker-util/eleven* /usr/local/bin; \
    chmod +x -R /usr/local/bin/eleven*; \
    eleven init;

# :: Build / apk
  FROM 11notes/apk:3.21 AS node

  # :: argument
    ARG TARGETARCH
    ARG APP_VERSION

  COPY --from=util /usr/local/bin/ /usr/local/bin

  RUN set -ex; \
    cd ${APP_ROOT}/.aports; \
    git pull; \
    echo "main/nodejs" >> .git/info/sparse-checkout; \
    cp -R ./main/nodejs /src;

  RUN set -ex; \
    cd /src/nodejs; \
    sed -i 's/^pkgver=.*/pkgver='${APP_VERSION}'/' ./APKBUILD; \
    sed -i 's/-Os}/-02}/' ./APKBUILD; \
    amake;

  RUN set -ex; \
    ls -lah /apk/x86_64/;


# :: Header
  FROM 11notes/alpine:stable

  # :: arguments
    ARG TARGETARCH
    ARG APP_IMAGE
    ARG APP_NAME
    ARG APP_VERSION
    ARG APP_ROOT

  # :: environment
    ENV APP_IMAGE=${APP_IMAGE}
    ENV APP_NAME=${APP_NAME}
    ENV APP_VERSION=${APP_VERSION}
    ENV APP_ROOT=${APP_ROOT}

  # :: multi-stage
    COPY --from=util /usr/local/bin/ /usr/local/bin
    COPY --from=node /apk/ /apk

# :: Run
  USER root

  # :: prepare image
    RUN set -ex; \
      mkdir -p ${APP_ROOT}/etc;

  # :: install application
    RUN set -ex; \
      ls -lah /apk/x86_64/*; \
      apk add --no-cache --repository /apk \
        nodejs; \
        node --version;

  # :: copy filesystem changes and set correct permissions
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin; \
      chown -R 1000:1000 \
        ${APP_ROOT};

# :: Volumes
  VOLUME ["${APP_ROOT}"]

# :: Monitor
  HEALTHCHECK --interval=5s --timeout=2s CMD curl -X GET -kILs --fail http://localhost:8080/ping || exit 1

# :: Start
  USER docker