# :: Header
	FROM node:18.16.0-alpine3.18

# :: Run
	USER root

  # :: update image
    RUN set -ex; \
      apk --update --no-cache add \
        tzdata \
        shadow; \
      apk update; \
      apk upgrade;

	# :: prepare image
		RUN set-ex; \
			mkdir -p /node;

	# :: copy root filesystem changes and add execution rights to init scripts
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin

  # :: set uid/gid to 1000:1000 for existing user
    RUN set -ex; \
      NOROOT_USER="node" \
      NOROOT_UID="$(id -u ${NOROOT_USER})"; \
      NOROOT_GID="$(id -g ${NOROOT_USER})"; \
      find / -not -path "/proc/*" -user ${NOROOT_UID} -exec chown -h -R 1000:1000 {} \;;\
      find / -not -path "/proc/*" -group ${NOROOT_GID} -exec chown -h -R 1000:1000 {} \;; \
      usermod -l docker node; \
      groupmod -n docker node;      
    
  # :: change home path for existing user and set correct permissions
    RUN set -ex; \
      usermod -d /node docker; \
      chown -R 1000:1000 \
        /node;

# :: Volumes
	VOLUME ["/node"]

# :: Start
	USER docker
	ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]