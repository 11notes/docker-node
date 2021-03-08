# :: Builder
    FROM alpine AS builder
    ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-aarch64.tar.gz
    RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . && mv qemu-3.0.0+resin-aarch64/qemu-aarch64-static .

# :: Header
    FROM arm64v8/node:14.16-buster
    COPY --from=builder qemu-aarch64-static /usr/bin

# :: Run
	USER root

	RUN mkdir -p /app \
		&& apk --update --no-cache add shadow
	ADD ./source/main.js /app/main.js

	# :: docker -u 1000:1000 (no root initiative)
		RUN usermod -u 1000 node \
		&& groupmod -g 1000 node \
		&& chown -R node:node /app

# :: Volumes
	VOLUME ["/app"]

# :: Start
	USER node
	CMD ["node", "/app/main.js"]