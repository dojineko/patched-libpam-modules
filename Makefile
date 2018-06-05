INFO_COLOR=\033[1;34m
RESET=\033[0m
BOLD=\033[1m

IMAGE_NAME=build-libpam-modules

build:
	@echo "$(INFO_COLOR)==> $(RESET)$(BOLD)Build patched libpam-modules_1.1.8 $(RESET)"
	docker rmi -f $(IMAGE_NAME)
	docker build . -t $(IMAGE_NAME)
	rm -rf dist && mkdir dist
	docker run -v $$PWD/dist:/volume -i build-libpam-modules bash -c 'cp /tmp/build/*.deb /volume'
