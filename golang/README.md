# Go Free Code Camp Tutorial

Go code somewhat following the FCC video on [Youtube](https://www.youtube.com/watch?v=YS4e4q9oBaU)

Go has not been installed locally and is run inside docker.

There are two ways to run this in Docker

## Docker Compose

Running Go inside a manually created docker file. Standalone which is great however any vs code extensions and go helper packages like gopls will not work as it cannot identify the `go env`.

### Development Commands

```
make dockerUp
make workApp
make dockerDown
make dockerFinal
make runApp
make stopApp
```

## VSCode Docker Containers

Letting VS Code itself create the docker container. Go extension packages will work (e.g. auto complete, formatting on save and linting) although it may ask you to install gopls.
The first time it creates the container will take a long time. As long as the image isn't deleted, the next time will be quicker.

Relies on the `.devcontainer.json` file. When opening workspace folder in VS Code, it should ask whether to run in container. Select yes.

Reference: [Documentation](https://code.visualstudio.com/docs/remote/containers#_using-docker-compose)

## Go Project Initialisation

Go modules for dependency management

```
// inside the container
go mod init github.com/<user>/<repo>

```

Also see the makefile for some helpful golang commands

```
GOOS=linux GOARCH=amd64 go build -o goapp ./src/*.go

go test ./... -cover -v

go clean -testcache

go fmt ./...
```
