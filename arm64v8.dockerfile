# :: Arch
  FROM alpine AS qemu
  ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-aarch64.tar.gz
  RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . && mv qemu-3.0.0+resin-aarch64/qemu-aarch64-static .

# :: Header
  FROM arm64v8/node:20.11.0-alpine3.19
  COPY --from=qemu qemu-aarch64-static /usr/bin
  ENV APP_ROOT=/node

# :: Run
	USER root

	# :: prepare image
		RUN set -ex; \
			mkdir -p ${APP_ROOT};

  # :: install applications
    RUN set -ex; \
      apk --no-cache add \
        curl \
        tzdata \
        shadow; \
      npm install npm@latest -g; \
      npm update -g;

  # :: update image
    RUN set -ex; \
      apk --no-cache upgrade;

  # :: set uid/gid to 1000:1000 for existing user
    RUN set -ex; \
      NOROOT_USER="node" \
      NOROOT_UID="$(id -u ${NOROOT_USER})"; \
      NOROOT_GID="$(id -g ${NOROOT_USER})"; \
      find / -not -path "/proc/*" -user ${NOROOT_UID} -exec chown -h -R 1000:1000 {} \;;\
      find / -not -path "/proc/*" -group ${NOROOT_GID} -exec chown -h -R 1000:1000 {} \;; \
      usermod -l docker ${NOROOT_USER}; \
      groupmod -n docker ${NOROOT_USER}; \
      usermod -d ${APP_ROOT} docker;

	# :: copy root filesystem changes and set correct permissions
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin; \
      chown -R 1000:1000 \
        ${APP_ROOT}

# :: Volumes
	VOLUME ["${APP_ROOT}"]

# :: Start
	USER docker
	ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]