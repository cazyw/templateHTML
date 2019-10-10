# Docker

In this project

```
docker build ./docker/ -t docker-node-image
```

Then inside the relvant project

```
docker run -d --rm -it -v ${PWD}:/app --port 8000:8000 --name docker-node docker-node-image
```

```
docker exec -it docker-node sh
```

```
docker container stop docker-node
docker container rm -v docker-node
```

## Port this to other projects

Copy these files to the relevant project:

- docker-compose.yml
- docker folder

Then run

```
docker-compose up --build -d
docker-compose exec nodedev sh
docker-compose down -v
```

## Additional commands

```
docker images
docker image prune -a

docker container ls -a
docker container stop <container name>
docker container prune
```
