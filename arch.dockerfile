# ╔═════════════════════════════════════════════════════╗
# ║                       SETUP                         ║
# ╚═════════════════════════════════════════════════════╝
  # GLOBAL
  ARG APP_UID=1000 \
      APP_GID=1000 \
      APP_VERSION=0 \
      APP_GO_VERSION=0

# FOREIGN IMAGES
  FROM 11notes/distroless AS distroless
  FROM 11notes/distroless:node-${APP_VERSION} AS distroless-node
  FROM 11notes/distroless:pnpm AS distroless-pnpm

# ╔═════════════════════════════════════════════════════╗
# ║                       BUILD                         ║
# ╚═════════════════════════════════════════════════════╝
# :: ENTRYPOINT
  FROM 11notes/go:${APP_GO_VERSION} AS entrypoint
  COPY ./build/entrypoint /go/entrypoint
  RUN set -ex; \
    cd /go/entrypoint; \
    eleven go build /entrypoint main.go; \
    eleven distroless /entrypoint;


# :: FILE-SYSTEM
  FROM alpine AS file-system
  ARG APP_ROOT
  RUN set -ex; \
    mkdir -p /distroless${APP_ROOT}/var; \
    mkdir -p /distroless${APP_ROOT}/run;


# ╔═════════════════════════════════════════════════════╗
# ║                       IMAGE                         ║
# ╚═════════════════════════════════════════════════════╝
# :: HEADER
  FROM scratch

  # :: default arguments
    ARG TARGETPLATFORM \
        TARGETOS \
        TARGETARCH \
        TARGETVARIANT \
        APP_IMAGE \
        APP_NAME \
        APP_VERSION \
        APP_ROOT \
        APP_UID \
        APP_GID \
        APP_NO_CACHE

  # :: default environment
    ENV APP_IMAGE=${APP_IMAGE} \
        APP_NAME=${APP_NAME} \
        APP_VERSION=${APP_VERSION} \
        APP_ROOT=${APP_ROOT}

  # :: app specific defaults
    ENV XDG_CONFIG_HOME=${APP_ROOT}/run

  # :: multi-stage
    COPY --from=distroless-node / /
    COPY --from=distroless-pnpm / /
    COPY --from=entrypoint /distroless/ /
    COPY --from=file-system --chown=${APP_UID}:${APP_GID} /distroless/ /

# :: EXECUTE
  USER ${APP_UID}:${APP_GID}
  ENTRYPOINT ["/usr/local/bin/entrypoint"]