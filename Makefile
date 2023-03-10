SOURCE_FILE ?= main.tex
BUILD_DIR ?= build
IMAGE_TAG ?= ubuntu

BASE_NAME:=$(basename $(SOURCE_FILE))

.PHONY: pdf
pdf:
	mkdir -p $(BUILD_DIR)
	docker run --rm -it \
		-v $(CURDIR):/workdir \
		$(DOCKER_IMAGE):$(IMAGE_TAG) sh -c 'latexmk -r latexmkrc -outdir=$(BUILD_DIR) $(BASE_NAME)'
	cp $(BUILD_DIR)/$(BASE_NAME).pdf $(BASE_NAME).pdf

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
	rm $(BASE_NAME).pdf

DOCKER_IMAGE=latex-env
MAKEFILE_DIR:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: ubuntu-img
ubuntu-img:
	docker build --network=host -t $(DOCKER_IMAGE):ubuntu -f $(MAKEFILE_DIR)/Dockerfile.ubuntu .

.PHONY: alpine-img
alpine-img:
	docker build --network=host -t $(DOCKER_IMAGE):alpine -f $(MAKEFILE_DIR)/Dockerfile.alpine .

.PHONY: ubuntu-sh
ubuntu-sh:
	docker run --rm -it -v $(PWD):/workdir $(DOCKER_IMAGE):ubuntu /bin/bash

.PHONY: alpine-sh
alpine-sh:
	docker run --rm -it -v $(PWD):/workdir $(DOCKER_IMAGE):alpine /bin/bash


