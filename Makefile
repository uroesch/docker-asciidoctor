# vim: shiftwidth=2 tabstop=2 noexpandtab :

DOCKER_USER    := uroesch
DOCKER_TAG     := asciidoctor
DOCKER_VERSION := $(shell awk -F : '/^FROM / { print $$(NF) }' Dockerfile)

.PHONY: all list to-latest help

all: build clean doc

git-commit:
	git commit -a -m "Release version $(DOCKER_VERSION) with changes from upstream"

git-tag: git-commit
	git tag $(DOCKER_VERSION)

git-push: git-tag
	git push
	git push --tags

to-latest:
	docker tag $(DOCKER_USER)/$(DOCKER_TAG):$(DOCKER_VERSION) \
		$(DOCKER_USER)/$(DOCKER_TAG):latest

push-as-latest: to-latest push
	docker push $(DOCKER_USER)/$(DOCKER_TAG):latest

push-only:
	docker push $(DOCKER_USER)/$(DOCKER_TAG):$(DOCKER_VERSION)

push: build push-only

list:
	docker images | grep packer

build:
	docker build \
		--tag $(DOCKER_USER)/$(DOCKER_TAG):$(DOCKER_VERSION) \
		.

build-no-cache:
	docker build \
    --no-cache \
    --tag $(DOCKER_USER)/$(DOCKER_TAG):$(DOCKER_VERSION) \
    .

force: build-no-cache

clean:
	VOLUMES="$(shell docker volume ls -qf dangling=true)"; \
	if [ -n "$${VOLUMES}" ]; then docker volume rm $${VOLUMES}; fi
	EXITED="$(shell docker ps -aqf dangling=exited)"; \
	if [ -n "$${EXITED}" ]; then  docker volume $${EXITED}; fi
	IMAGES="$(shell docker images -qf dangling=true)"; \
	if [ -n "$${IMAGES}" ]; then docker rmi $${IMAGES}; fi

doc:
	asciidoctor -b docbook -a leveloffset=+1 -o - README.adoc | \
		pandoc --atx-headers --wrap=preserve -t gfm -f docbook - > README.md

help:
	@printf "Usage: \n\n"; \
	printf "  make %-16s %s\n" \
		all             "Build, clean and create documents." \
		clean           "Cleanup docker's cache." \
		doc             "Build documentation." \
		force           "Build with no cache." \
		git-commit      "Create a commit from the latest version." \
		git-push        "Run git-tag and then push to the upstream repo." \
		git-tag         "Create a git tag after running git-commit." \
		help            "This message." \
		push            "Push to docker hub after building." \
		push-as-latest  "Push to docker after taging the release as latest." \
		push-only       "Push to docker hub without building the container." \
		to-latest       "Tag as latest."
