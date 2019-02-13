FROM multiarch/alpine:armhf-v3.9

RUN apk update && apk upgrade
RUN apk add \
bash \
coreutils \
dosfstools \
e2fsprogs \
file \
libcap \
parted \
pv \
qemu \
shadow \
udev \
util-linux \
wget \
zip

VOLUME /share
VOLUME /build

COPY bin/* /usr/local/bin/

ENTRYPOINT [ "/usr/local/bin/entrypoint" ]
