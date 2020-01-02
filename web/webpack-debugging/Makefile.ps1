function Up {
  docker build . -t docker-node-image
  docker run -d --rm -it -v ${PWD}:/app --name docker-node docker-node-image
}