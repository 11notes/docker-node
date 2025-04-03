# :: Util
  FROM 11notes/util AS util

# :: Build / node
  FROM alpine AS build
  ARG TARGETARCH
  ARG APP_VERSION
  ENV BUILD_DIR=/node-v${APP_VERSION}
  ENV BUILD_BIN=/node-v${APP_VERSION}/out/Release/node

  USER root

  COPY --from=util /usr/local/bin/ /usr/local/bin

  RUN set -ex; \
    apk --update --no-cache add \
      wget \
      binutils-gold \
      g++ \
      gcc \
      gnupg \
      libgcc \
      linux-headers \
      make \
      python3 \
      curl \
      upx \
      py-setuptools;

  RUN set -ex; \
    cd /; \
    wget "https://nodejs.org/dist/v${APP_VERSION}/node-v${APP_VERSION}.tar.xz"; \
    tar -xf "node-v${APP_VERSION}.tar.xz";

  RUN set -ex; \
    cd ${BUILD_DIR}; \
    ./configure --fully-static --enable-static; \
    make -s -j $(nproc);

  RUN set -ex; \
    mkdir -p /distroless/usr/local/bin; \
    eleven strip ${BUILD_BIN}; \
    cp ${BUILD_BIN} /distroless/usr/local/bin;

# :: Distroless / node
  FROM scratch AS distroless-node
  ARG APP_ROOT
  COPY --from=build /distroless/ /


# :: Build / file system
  FROM alpine AS fs
  ARG APP_ROOT
  USER root

  RUN set -ex; \
    mkdir -p ${APP_ROOT};

# :: Distroless / file system
  FROM scratch AS distroless-fs
  ARG APP_ROOT
  USER root
  COPY --from=fs ${APP_ROOT} /${APP_ROOT}

# :: Header
  FROM 11notes/distroless AS distroless
  FROM scratch

  # :: arguments
    ARG TARGETARCH
    ARG APP_IMAGE
    ARG APP_NAME
    ARG APP_VERSION
    ARG APP_ROOT
    ARG APP_UID
    ARG APP_GID

  # :: environment
    ENV APP_IMAGE=${APP_IMAGE}
    ENV APP_NAME=${APP_NAME}
    ENV APP_VERSION=${APP_VERSION}
    ENV APP_ROOT=${APP_ROOT}

  # :: multi-stage
    COPY --from=distroless --chown=${APP_UID}:${APP_GID} / /
    COPY --from=distroless-fs --chown=${APP_UID}:${APP_GID} / /
    COPY --from=distroless-node --chown=${APP_UID}:${APP_GID} / /

# :: Volumes
  VOLUME ["${APP_ROOT}"]

# :: Start
  USER docker
  ENTRYPOINT ["/usr/local/bin/node"]