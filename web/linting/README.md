# Linting Template

This runs inside docker

## Docker

```
docker build . -t docker-node-image
```

```
docker run -d --rm -it -v ${PWD}:/app --name docker-node docker-node-image
```

```
docker exec -it docker-node sh
```

## Additional commands

```
docker images
docker image prune -a

docker container ls -a
docker container stop <container name>
docker container prune
```
