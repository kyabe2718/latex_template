TARGET=dc.tex
BUILD_DIR=build
BASE_NAME=$(basename $(TARGET))
DOCKER_IMAGE=latex_container

# pdf: $(TARGET)
# 	mkdir -p $(BUILD_DIR)
# 	docker run --rm -it \
# 		-v $(CURDIR):/workdir \
# 		$(DOCKER_IMAGE) sh -c 'latexmk -r latexmkrc -outdir=$(BUILD_DIR) $(BASE_NAME)'
# 	cp $(BUILD_DIR)/$(BASE_NAME).pdf $(BASE_NAME).pdf

.PHONY: build-ubuntu
build-ubuntu:
	cd ubuntu && docker build --network=host -t $(DOCKER_IMAGE):ubuntu .

# .PHONY: clean
# clean:
# 	rm -rf $(BUILD_DIR)
# 	rm $(BASE_NAME).pdf

sh-ubuntu:
	docker run --rm -it -v $(PWD):/workdir $(DOCKER_IMAGE):ubuntu /bin/bash
