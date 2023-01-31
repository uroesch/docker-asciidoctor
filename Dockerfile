FROM asciidoctor/docker-asciidoctor:1.38.0
MAINTAINER Urs Roesch <github@bun.ch>

# install base tools for docker build
RUN apk add --no-cache sassc
