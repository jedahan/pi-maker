MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash

TAG?=latest

build:
	docker run --rm --privileged multiarch/qemu-user-static:register --reset
	docker build -t "pi-maker:${TAG}" .
