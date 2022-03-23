# :: Header
	FROM node:17-alpine

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