# :: Header
	FROM node:16.17.0-alpine3.16

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