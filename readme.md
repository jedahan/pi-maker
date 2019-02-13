
# pi-maker

A docker container and simple scripts that makes it easy to build custom images for the raspberry pi from your computer, ready-to-bake onto an sd card.

## getting started

Create the docker container

    make pi-maker

Create a simple raspbian image

    make -f makefile.raspbian

Create an arch linux image

    make -f makefile.arch

## customization


The easiest way to customize the image build process, is to put whatever files you want in `share/` and edit `share/setup` to run whatever scripts you want.

Remember the scripts will run as root so if you want to do something as the pi user, prefix it with `sudo -u pi dothething`.

## customizing the base operating system

To build an image, pi-maker needs to know a few things:

The path to your starting OS image:

    --env OS_IMAGE=archlinux.tar.xz

A directory to copy over to the pi after the OS is loaded (mount to /share)

    --volume ${PWD}/share:/share

The script you'd like to run after copying over everything from /share

    --env SETUP_SCRIPT=/setup

The directory to copy the finished image to

    --volume ${PWD}/build:/build

The size you'd like your image to be

    --env IMG_SIZE=4G

Putting it all together, you might have

For example, from the makefile `build` entry:

    docker run -it --privileged \
      --volume ${PWD}/share:/share \
      --env OS_IMAGE=combined.tar \
      --env SETUP_SCRIPT=/setup \
      --volume ${PWD}/build:/build \
      --env IMAGE_SIZE=4G \
      pi-maker:latest

By exporting `OS_IMAGE`, and/or `OS_URI` you can use a different operating system, like so:

```bash
# Creating a raspbian image requires merging the boot partition into the root tar
pushd build
export LATEST_BUILD='2018-11-15-21:03'
wget http://vx2-downloads.raspberrypi.org/raspbian_lite/archive/${LATEST_BUILD}/boot.tar.xz
wget http://vx2-downloads.raspberrypi.org/raspbian_lite/archive/${LATEST_BUILD}/root.tar.xz
unxz root.tar.xz
mkdir -p boot && tar -xf boot.tar.xz -C boot && sudo chown -R 0 boot && sudo chgrp -R 0 boot
tar -rf root.tar boot && sudo rm -rf boot
export IMAGE_SIZE=4G
export OS_IMAGE=root.tar
popd
make run
```

## Reference
- [Raspberry Pi: How to Install and Configure Archlinux ARM](http://populationinversion.com/posts/raspberrypi-install-and-configure-archlinux-arm/)
- [Create Custom ArchlinuxArm Images for the Raspberry Pi](https://disconnected.systems/blog/raspberry-pi-archlinuxarm-setup)
- [Building ARM containers on any x86 machine, even DockerHub](https://resin.io/blog/building-arm-containers-on-any-x86-machine-even-dockerhub/)
