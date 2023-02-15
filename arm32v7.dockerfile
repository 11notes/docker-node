# :: Builder
    FROM alpine AS builder
    ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-arm.tar.gz
    RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . && mv qemu-3.0.0+resin-arm/qemu-arm-static .

# :: Header
    FROM arm32v7/node:18.14.0-alpine
    COPY --from=builder qemu-arm-static /usr/bin

# :: Run
	USER root

	# :: prepare
		RUN set-ex; \
			mkdir -p /node_modules; \
			mkdir -p /node; \
			apk --update --no-cache add \
				shadow;

	# :: copy root filesystem changes
        COPY ./rootfs /

    # :: docker -u 1000:1000 (no root initiative)
        RUN set -ex; \
            usermod -u 1000 node; \
			groupmod -g 1000 node; \
			chown -R node:node \
				/node \
				/node_modules;

# :: Volumes
	VOLUME ["/node"]

# :: Start
	RUN set -ex; chmod +x /usr/local/bin/entrypoint.sh
	USER node
	ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]