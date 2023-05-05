# :: Header
	FROM node:18.16.0-alpine3.17

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