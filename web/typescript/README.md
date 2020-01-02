# Typescript Template

Typescript template that uses Typescript, Eslint and Prettier

There are two ways to run this in Docker

## Docker Compose

Running Javascript/Typescript inside a manually created docker file. Standalone which is great however any vs code extensions such as eslint, prettier etc will not work.

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

Letting VS Code itself create the docker container. VS Code extension packages that are listed in `.devcontainer.json` will work e.g. auto complete, formatting on save and linting.
The first time it creates the container will take a long time. As long as the image isn't deleted, the next time will be quicker.

Relies on the `.devcontainer.json` file. When opening workspace folder in VS Code, it should ask whether to run in container. Select yes.

Reference: [Documentation](https://code.visualstudio.com/docs/remote/containers#_using-docker-compose)

## NPM Tasks

```
npm test
npm run build
```
