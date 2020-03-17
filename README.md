# docker-node
Simple alpine container with node installed

## Volumes
/app

Purpose: Directory of your application, starting with "main.js"

## Run
```shell
docker run --name app \
    -v volume-app:/app \
    -d 11notes/node:stable
```

## Docker -u 1000:1000 (no root initiative)
As part to make containers more secure, this container will not run as root, but as uid:gid 1000:1000. Therefore your application should not bind to ports < 1024!

## Build with
* [node](https://nodejs.org/en/) - Nodejs
* [Alpine Linux](https://alpinelinux.org/) - Alpine Linux

## Tips
* Don't bind to ports < 1024 (requires root), use NAT
* [Permanent Storge with NFS/CIFS/...](https://github.com/11notes/alpine-docker-netshare) - Module to store permanent container data via NFS/CIFS/...