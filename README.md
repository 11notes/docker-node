# Alpine :: Nodejs
Run Nodejs based on Alpine Linux. Small, lightweight, secure and fast 🏔️

## Volumes
* **/node** - Directory of your application (app.js)

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
    node /node/my/app.js
```

## Defaults
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |
| `home` | /node | home directory of user docker |
| `app` | /node/app.js | will try to run app.js by default |

## Parent
* [11notes/alpine:stable](https://github.com/11notes/docker-alpine)

## Built with
* [nodejs](https://nodejs.org/en)
* [Alpine Linux](https://alpinelinux.org)

## Tips
* Don't bind to ports < 1024 (requires root), use NAT/reverse proxy
* [Permanent Stroage](https://github.com/11notes/alpine-docker-netshare) - Module to store permanent container data via NFS/CIFS and more