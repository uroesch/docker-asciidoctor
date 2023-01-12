FROM asciidoctor/docker-asciidoctor
MAINTAINER Urs Roesch <github@bun.ch>

#VERSION 1.37.1

# install base tools for docker build
RUN apk add --no-cache sassc
