# Alpine :: Nodejs
![size](https://img.shields.io/docker/image-size/11notes/node/20.11.0?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/node?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/node?color=2b75d6) ![activity](https://img.shields.io/github/commit-activity/m/11notes/docker-node?color=c91cb8) ![commit-last](https://img.shields.io/github/last-commit/11notes/docker-node?color=c91cb8)

Run Nodejs based on Alpine Linux. Small, lightweight, secure and fast 🏔️

## Volumes
* **/node** - Directory of your application (either package.json or main.js)

## Run
```shell
docker run --name node \
  -v ../node:/node \
  -d 11notes/node:[tag]
```

## Defaults
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |
| `home` | /node | home directory of user docker |

## Parent image
* [11notes/alpine:stable](https://github.com/11notes/docker-alpine)

## Built with and thanks to
* [nodejs](https://nodejs.org/en)
* [Alpine Linux](https://alpinelinux.org)

## Tips
* Only use rootless container runtime (podman, rootless docker)
* Don't bind to ports < 1024 (requires root), use NAT/reverse proxy (haproxy, traefik, nginx)