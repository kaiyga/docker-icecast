# Icecast in Docker 

Icecast2 Dockerfile

[![](http://dockeri.co/image/moul/icecast)](https://index.docker.io/u/moul/icecast/)

## Run

Run with default password, export port 8000

```bash
docker run -p 8000:8000 moul/icecast
$BROWSER localhost:8000
```

Run with custom password

```bash
docker run -p 8000:8000 \ 
    -e ICECAST_SOURCE_PASSWORD=aaaa \ 
    -e ICECAST_ADMIN_PASSWORD=bbbb \
    -e ICECAST_PASSWORD=cccc \ 
    -e ICECAST_RELAY_PASSWORD=dddd \
    -e ICECAST_STREAM_PASSWORD=stream_pass \ 
    -e ICECAST_HOSTNAME=noise.example.com moul/icecast

docker run -p 8000:8000 --env-file config.env moul/icecast

```

Run with custom configuration

```bash
docker run -p 8000:8000 -v /local/path/to/icecast/config:/etc/icecast2 moul/icecast
docker run -p 8000:8000 -v icecast.yaml:/etc/icecast2/values.yaml moul/icecast
```

Extends Dockerfile

```Dockerfile
FROM moul/icecast
ADD ./icecast.xml /etc/icecast2
```

Docker-compose

```yaml
icecast:
  image: moul/icecast
  volumes:
  - logs:/var/log/icecast2
  - /etc/localtime:/etc/localtime:ro
  environment:
  - ICECAST_SOURCE_PASSWORD=aaa
  - ICECAST_ADMIN_PASSWORD=bbb
  - ICECAST_PASSWORD=ccc
  - ICECAST_RELAY_PASSWORD=ddd
  - ICECAST_HOSTNAME=noise.example.com
  - ICECAST_STREAM_PASSWORD=stream_pass

  ports:
  - 8000:8000
```

## How it works

The container takes a base configurations file [`/etc/icecast2/values.yaml`](./etc/icecast2/values.yaml) and renders it into the final `icecast.xml` using a Go [`icecast.xml.tpl`](./etc/icecast2/icecast.xml.tpl) template.

To dynamic support environment variables, the `values.yaml` is pre-processed with [`envsubst`](https://man7.org/linux/man-pages/man1/envsubst.1.html) at container startup. This allows you to inject credentials and ports on the fly. For advanced use cases, you can easily override the default `values.yaml` using Docker volumes to `/etc/icecast2/values.yaml`.

This two-step pipeline (`envsubst` -> `tpl`) ensures that Icecast configuration remains extremely flexible

## License

[MIT](https://github.com/moul/docker-icecast/blob/master/LICENSE.md)

## Thanks

- [bluebrown/go-template-cli](https://github.com/bluebrown/go-template-cli)
- [moul/docker-icecast](https://github.com/moul/docker-icecast)
- [Bruno Haible for envsubst](https://man7.org/linux/man-pages/man1/envsubst.1.html#AUTHOR)
