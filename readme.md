
# pi-maker

### Getting Started

```bash
make && make run
```

<<<<<<< HEAD
A new disk image for Raspberry Pi will appear inside the **build** folder. This solution has been tested with Raspberry Pi Zero W and may work for other models, too.
=======
A new disk image for Raspberry Pi will appear inside this project folder within "share/build". This solution has been tested with Raspberry Pi Zero W and may work for other models, too.
>>>>>>> b3ba0b76e54c8fa72c10aa6f6a56319b3a7794ad

### Next: Flash With Desktop App

[Download Etcher](http://etcher.io)

Open the desktop application and follow the prompts to select the disk image and the desired SD Card to use.

### Or: Flash With Command Line

[Install Etcher CLI](https://etcher.io/cli/)

Run the commands below and the terminal will prompt you to select the desired drive to install to. Please be careful to select the proper SD Card and not another disk to avoid unwanted data loss.

```bash
make && make run
make flash
```

### Requirements

A local [Docker](https://www.docker.com/community-edition) environment is required in order to build an image.

### Customization

<<<<<<< HEAD
The docker entrypoint runs whatever CMD you pass it to as root from within the emulated pi container.

For example, from the makefile run entry:

    docker run -it --privileged \
      --volume ${PWD}/share:/share \ # mount the share folder
      --volume ${PWD}/build:/build \ # mount the build folder
      pi-maker:latest /setup # run the /setup script that was in /share

The easiest way to customize the image build process, is to put whatever files you want in `share/` and edit `share/setup` to run whatever scripts you want.

Remember the scripts will run as root so if you want to do something as the pi user, prefix it with `sudo -u pi dothething`.
=======
The docker entrypoint mainly does two things:

  1. copies all files from `share/copy-this` to the root filesystem
  2. runs `share/setup` (as root)
    * ...which runs `share/my-scripts/test-script` by default

The easiest way to customize the image build process, is to put scripts in `share/my-scripts`,
and edit `share/setup` to run whatever scripts you want. Remember the scripts will run as root
so if you want to do something as the pi user, prefix it with `sudo -u pi dothething`.
>>>>>>> b3ba0b76e54c8fa72c10aa6f6a56319b3a7794ad

#### Customizing the base OS

By exporting `OS_IMAGE`, and/or `OS_URI` you can use a different operating system, like so:

```bash
# Creating a raspbian image requires merging the boot partition into the root tar
<<<<<<< HEAD
pushd build
=======
pushd share/build
>>>>>>> b3ba0b76e54c8fa72c10aa6f6a56319b3a7794ad
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
