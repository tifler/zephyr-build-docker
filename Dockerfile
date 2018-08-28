FROM ubuntu:18.04
MAINTAINER nungdo@gmail.com

ENV ZEPHYR_BASE=/zephyr
ENV ZEPHYR_GCC_VARIANT=zephyr
ENV ZEPHYR_SDK_INSTALL_DIR=/opt/zephyr-sdk
ENV ZEPHYR_SDK_VERSION=0.9.3

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get -y install --no-install-recommends git cmake ninja-build gperf \
        ccache doxygen dfu-util device-tree-compiler \
        python3-ply python3-pip python3-setuptools python3-wheel xz-utils file \
        make gcc-multilib autoconf automake libtool wget

RUN wget -O /tmp/zephyr-setup https://github.com/zephyrproject-rtos/meta-zephyr-sdk/releases/download/${ZEPHYR_SDK_VERSION}/zephyr-sdk-${ZEPHYR_SDK_VERSION}-setup.run \
        && chmod 755 /tmp/zephyr-setup \
        && /tmp/zephyr-setup --quiet \
        && rm /tmp/zephyr-setup

RUN git clone --depth 1 https://github.com/zephyrproject-rtos/zephyr.git $ZEPHYR_BASE \
        && cd $ZEPHYR_BASE \
        && pip3 install --user -r scripts/requirements.txt

WORKDIR /data

