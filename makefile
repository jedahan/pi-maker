MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash

TAG?=latest
BUILDER?=lantern/pi-maker:$(TAG)
OS_IMAGE?=ArchLinuxARM-rpi-latest.tar.gz
OS_URI?=http://os.archlinuxarm.org/os/$(OS_IMAGE)
IMAGE_SIZE?=3G
CMD?=/setup

pimaker:
	docker run --rm --privileged multiarch/qemu-user-static:register --reset
	docker build -t "${BUILDER}" .

run:
	docker run -it --privileged \
		-e OS_IMAGE="$(OS_IMAGE)" \
		-e OS_URI="$(OS_URI)" \
		-e IMAGE_SIZE="$(IMAGE_SIZE)" \
		-v ${PWD}/share:/share \
		-v ${PWD}/build:/build \
		${BUILDER} $(CMD)

flash: build run
	etcher build/rpi.img
