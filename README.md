# docker-node

Nodejs container

## Volumes
* **/node** - Directory of your application

## Run
```shell
docker run --name node \
  -v ../node:/node \
  -d 11notes/node:[tag]
```

```shell
docker run --name node \
  -v ../node:/node \
  -d 11notes/node:[tag] \
    node /node/path/to/your/app.js
```

## Defaults
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |

## Parent
* [11notes/alpine:stable](https://github.com/11notes/docker-alpine)

## Built with
* [nodejs](https://nodejs.org/en/)
* [Alpine Linux](https://alpinelinux.org/)

## Tips
* Don't bind to ports < 1024 (requires root), use NAT/reverse proxy
* [Permanent Storge with NFS/CIFS/...](https://github.com/11notes/alpine-docker-netshare) - Module to store permanent container data via NFS/CIFS/...