.PHONY: run build template

DOCKER_IMAGE = jekyll
WORK_DIR     = /srv/jekyll
CURRENT_PATH = $(shell pwd)

build:
	docker build --rm -t $(DOCKER_IMAGE) .

run:
	docker run --rm -v $(CURRENT_PATH):$(WORK_DIR) -p 127.0.0.1:4000:4000 $(DOCKER_IMAGE)

template:
	docker run --rm -v $(CURRENT_PATH):$(WORK_DIR) $(DOCKER_IMAGE) /bin/sh -c 'cd /srv ; jekyll new --force jekyll'

all: build run
