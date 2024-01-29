FROM asciidoctor/docker-asciidoctor:1.63.0
MAINTAINER Urs Roesch <github@bun.ch>

# install base tools for docker build
RUN apk add --no-cache sassc ruby-ffi

# install gems
RUN gem install compass zurb-foundation
