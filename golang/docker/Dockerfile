# develop
FROM golang:1.13.3-alpine AS develop
RUN apk update && apk upgrade && \
  apk add --no-cache \
  bash \
  git \
  openssh \
  gcc \
  libc-dev \
  make \
  tree \
  jq \
  python \
  python-dev \
  py-pip \
  build-base \
  && pip install awscli \
  && apk --purge -v del py-pip \
  && rm -rf /var/cache/apk/*
EXPOSE 8080

# build
FROM develop AS build
COPY ./ /gofcc/
WORKDIR /gofcc/
RUN make toLinux

# final
FROM alpine:latest
RUN apk update && apk upgrade \
  && apk add --no-cache ca-certificates \
  && rm -rf /var/cache/apk/*
COPY --from=build /gofcc/goapp /bin/goapp
EXPOSE 8080
CMD ["./bin/goapp"]