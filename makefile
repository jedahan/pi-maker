MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash

TAG?=latest
OS_IMAGE?=ArchLinuxARM-rpi-latest.tar.gz
OS_URI?=http://os.archlinuxarm.org/os/$(OS_IMAGE)
IMAGE_SIZE?=3G

build:
	docker run --rm --privileged multiarch/qemu-user-static:register --reset
	docker build -t "lantern/pi-maker:${TAG}" .

run:
	docker run -it --privileged \
		-e OS_IMAGE="$(OS_IMAGE)" \
		-e OS_URI="$(OS_URI)" \
		-e IMAGE_SIZE="$(IMAGE_SIZE)" \
		-v ${PWD}/share:/share \
		-v ${PWD}/build:/build \
		lantern/pi-maker:${TAG} /setup

flash: build run
	etcher build/rpi.img
