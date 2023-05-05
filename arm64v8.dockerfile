# :: Builder
    FROM alpine AS qemu
    ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-aarch64.tar.gz
    RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . && mv qemu-3.0.0+resin-aarch64/qemu-aarch64-static .

# :: Header
    FROM arm64v8/node:18.16.0-alpine3.17
    COPY --from=qemu qemu-aarch64-static /usr/bin

# :: Run
	USER root

  # :: update image
    RUN set -ex; \
      apk --update --no-cache add \
        tzdata \
        shadow; \
      apk update; \
      apk upgrade;

	# :: prepare
		RUN set-ex; \
			mkdir -p /node;

	# :: copy root filesystem changes
    COPY ./rootfs /

  # :: docker -u 1000:1000 (no root initiative)
    RUN set -ex; \
      usermod -u 1000 node; \
      groupmod -g 1000 node; \
      chown -R node:node \
        /node;

# :: Volumes
	VOLUME ["/node"]

# :: Start
	RUN set -ex; chmod +x /usr/local/bin/entrypoint.sh
	USER node
	ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]