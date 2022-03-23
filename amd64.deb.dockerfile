# :: Header
	FROM node:14-bullseye

# :: Run
	USER root

	RUN mkdir -p /app
	ADD ./source/main.js /app/main.js

	# :: docker -u 1000:1000 (no root initiative)
		RUN usermod -u 1000 node \
		&& groupmod -g 1000 node \
		&& chown -R node:node /app

# :: Volumesusermod

	VOLUME ["/app"]

# :: Start
	USER node
	CMD ["node", "/app/main.js"]