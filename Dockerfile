FROM asciidoctor/docker-asciidoctor:1.40.0
MAINTAINER Urs Roesch <github@bun.ch>

# install base tools for docker build
RUN apk add --no-cache sassc
