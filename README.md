![banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# NODE
[<img src="https://img.shields.io/badge/github-source-blue?logo=github&color=040308">](https://github.com/11notes/docker-NODE)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![size](https://img.shields.io/docker/image-size/11notes/node/22.14.0?color=0eb305)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![version](https://img.shields.io/docker/v/11notes/node/22.14.0?color=eb7a09)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![pulls](https://img.shields.io/docker/pulls/11notes/node?color=2b75d6)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)[<img src="https://img.shields.io/github/issues/11notes/docker-NODE?color=7842f5">](https://github.com/11notes/docker-NODE/issues)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![swiss_made](https://img.shields.io/badge/Swiss_Made-FFFFFF?labelColor=FF0000&logo=data:image/svg%2bxml;base64,PHN2ZyB2ZXJzaW9uPSIxIiB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgdmlld0JveD0iMCAwIDMyIDMyIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGQ9Im0wIDBoMzJ2MzJoLTMyeiIgZmlsbD0iI2YwMCIvPjxwYXRoIGQ9Im0xMyA2aDZ2N2g3djZoLTd2N2gtNnYtN2gtN3YtNmg3eiIgZmlsbD0iI2ZmZiIvPjwvc3ZnPg==)

Run your node applications rootless and distroless

# MAIN TAGS 🏷️
These are the main tags for the image. There is also a tag for each commit and its shorthand sha256 value.

* [22.14.0](https://hub.docker.com/r/11notes/node/tags?name=22.14.0)
* [stable](https://hub.docker.com/r/11notes/node/tags?name=stable)
* [latest](https://hub.docker.com/r/11notes/node/tags?name=latest)

# REPOSITORIES ☁️
```
docker pull 11notes/node:22.14.0
docker pull ghcr.io/11notes/node:22.14.0
docker pull quay.io/11notes/node:22.14.0
```

# SYNOPSIS 📖
**What can I do with this?** Run your node applications as light and as secure as possible. This image is not meant for development purposes, but to run your compiled (ncc) apps.

# UNIQUE VALUE PROPOSITION 💶
**Why should I run this image and not the other image(s) that already exist?** Good question! All the other images on the market that do exactly the same don’t do or offer these options:

> [!IMPORTANT]
>* This image runs as 1000:1000 by default, most other images run everything as root
>* This image has no shell since it is 100% distroless, most other images run on a distro like Debian or Alpine with full shell access (security)
>* This image does not ship with any critical or high rated CVE and is automatically maintained via CI/CD, most other images mostly have no CVE scanning or code quality tools in place
>* This image is created via a secure, pinned CI/CD process and immune to upstream attacks, most other images have upstream dependencies that can be exploited
>* This image works as read-only, most other images need to write files to the image filesystem

If you value security, simplicity and the ability to interact with the maintainer and developer of an image. Using my images is a great start in that direction.

# VOLUMES 📁
* **/node** - Directory of your app

# COMPOSE ✂️
```yaml
name: "node"
services:
  node:
    image: "11notes/node:22.14.0"
    read_only: true
    environment:
      TZ: "Europe/Zurich"
    volumes:
      - "node:/node"
    networks:
      frontend:
    restart: "always"

volumes:
  node:

networks:
  frontend:
```

# DEFAULT SETTINGS 🗃️
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user name |
| `uid` | 1000 | [user identifier](https://en.wikipedia.org/wiki/User_identifier) |
| `gid` | 1000 | [group identifier](https://en.wikipedia.org/wiki/Group_identifier) |
| `home` | /node | home directory of user docker |

# ENVIRONMENT 📝
| Parameter | Value | Default |
| --- | --- | --- |
| `TZ` | [Time Zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | |
| `DEBUG` | Will activate debug option for container image and app (if available) | |

# SOURCE 💾
* [11notes/node](https://github.com/11notes/docker-NODE)

# PARENT IMAGE 🏛️
> [!IMPORTANT]
>This image is not based on another image but uses [scratch](https://hub.docker.com/_/scratch) as the starting layer.
>The image consists of the following distroless layers that were added:
>* [11notes/distroless](https://github.com/11notes/docker-distroless/blob/master/arch.dockerfile) - contains users, timezones and Root CA certificates

# BUILT WITH 🧰
* [node](https://github.com/nodejs/node)

# GENERAL TIPS 📌
> [!TIP]
>* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS and to protect your endpoints
>* Use Let’s Encrypt DNS-01 challenge to obtain valid SSL certificates for your services

# ElevenNotes™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/11notes/docker-node/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-node/issues), thanks. If you have a question or inputs please create a new [discussion](https://github.com/11notes/docker-node/discussions) instead of an issue. You can find all my other repositories on [github](https://github.com/11notes?tab=repositories).

*created 09.04.2025, 11:46:40 (CET)*