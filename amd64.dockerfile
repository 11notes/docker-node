# :: Header
	FROM node:18.16.1-alpine3.18
  ENV APP_ROOT=/node

# :: Run
	USER root

  # :: update image
    RUN set -ex; \
      apk --update --no-cache add \
        curl \
        tzdata \
        shadow;

	# :: prepare image
		RUN set-ex; \
			mkdir -p ${APP_ROOT};

	# :: copy root filesystem changes and add execution rights to init scripts
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin;

  # :: set uid/gid to 1000:1000 for existing user
    RUN set -ex; \
      NOROOT_USER="node" \
      NOROOT_UID="$(id -u ${NOROOT_USER})"; \
      NOROOT_GID="$(id -g ${NOROOT_USER})"; \
      find / -not -path "/proc/*" -user ${NOROOT_UID} -exec chown -h -R 1000:1000 {} \;;\
      find / -not -path "/proc/*" -group ${NOROOT_GID} -exec chown -h -R 1000:1000 {} \;; \
      usermod -l docker ${NOROOT_USER}; \
      groupmod -n docker ${NOROOT_USER};      
    
  # :: change home path for existing user and set correct permission
    RUN set -ex; \
      usermod -d ${APP_ROOT} docker; \
      chown -R 1000:1000 \
        ${APP_ROOT};

  # :: update image binaries and empty cache
    RUN set -ex; \
      apk --no-cache --update upgrade; \
      apk cache clean;

# :: Volumes
	VOLUME ["${APP_ROOT}"]

# :: Start
	USER docker
	ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]