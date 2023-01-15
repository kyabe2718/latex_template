TARGET=main.tex
BUILD_DIR=build
BASE_NAME=$(basename $(TARGET))
DOCKER_IMAGE=mytexlive

pdf: $(TARGET)
	mkdir -p $(BUILD_DIR)
	docker run --rm -it \
		-v $(CURDIR):/workdir \
		$(DOCKER_IMAGE) sh -c 'latexmk -r latexmkrc -outdir=$(BUILD_DIR) $(BASE_NAME)'
	cp $(BUILD_DIR)/$(BASE_NAME).pdf $(BASE_NAME).pdf

.PHONY: ubuntu-img
ubuntu-img:
	docker build --network=host -t $(DOCKER_IMAGE):ubuntu -f Dockerfile.ubuntu .

.PHONY: alpine-img
alpine-img:
	docker build --network=host -t $(DOCKER_IMAGE):alpine -f Dockerfile.alpine .

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
	rm $(BASE_NAME).pdf

.PHONY: ubuntu-sh
ubuntu-sh:
	docker run --rm -it -v $(PWD):/workdir $(DOCKER_IMAGE):ubuntu /bin/bash

.PHONY: alpine-sh
alpine-sh:
	docker run --rm -it -v $(PWD):/workdir $(DOCKER_IMAGE):alpine /bin/bash
