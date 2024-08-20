![Banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# 🏔️ Alpine - Node.js
![size](https://img.shields.io/docker/image-size/11notes/node/20.16.0?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/node/20.16.0?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/node?color=2b75d6) ![stars](https://img.shields.io/docker/stars/11notes/node?color=e6a50e) [<img src="https://img.shields.io/badge/github-11notes-blue?logo=github">](https://github.com/11notes)

**Nodejs on Alpine. Lightweight, secure and fast!**

# SYNOPSIS
What can I do with this? Run your node applications directly in Docker by mounting your code via /node either as main.js or as package.json.

# VOLUMES
* **/node/node** - Directory of your application (either package.json or main.js)

# COMPOSE
```yaml
services:
  node:
    image: "11notes/node:20.16.0"
    container_name: "node"
    environment:
      TZ: Europe/Zurich
    volumes:
      - "node:/node"
    restart: always
volumes:
  node:
```

# DEFAULT SETTINGS
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |
| `home` | /node | home directory of user docker |

# ENVIRONMENT
| Parameter | Value | Default |
| --- | --- | --- |
| `TZ` | [Time Zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | |
| `DEBUG` | Show debug information | |

# PARENT IMAGE
* [node:20.16.0-alpine3.20](https://hub.docker.com/_/node)

# BUILT WITH
* [nodejs](https://nodejs.org/en)
* [alpine](https://alpinelinux.org)

# TIPS
* Use a reverse proxy like Traefik, Nginx to terminate TLS with a valid certificate
* Use Let’s Encrypt certificates to protect your SSL endpoints

# ElevenNotes<sup>™️</sup>
This image is provided to you at your own risk. Always make backups before updating an image to a new version. Check the changelog for breaking changes. You can find all my repositories on [github](https://github.com/11notes).
    