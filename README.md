# Docker Image for asciidoctor

![gitlab avatar](icons/gitlab-avatar.png)

Docker container based on `asciidoctor/docker-asciidoctor` with addtional tools
added.

## Installed Tools

  - `sassc` for handling asciidoctor templates

  - `ruby-ffi` to install the the `compass` gem.

  - `compass` ruby gem to compile themes.

## Extras

  - @rapper script in `bin` called `docker-asciidoctor` to run the container
