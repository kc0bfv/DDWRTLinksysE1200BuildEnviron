# vim:set ft=dockerfile:

FROM debian:stable-slim

RUN set -eux; apt-get update; apt-get install -y --no-install-recommends build-essential clang flex g++ gawk gcc-multilib gettext git libncurses5-dev libssl-dev python3-distutils rsync unzip zlib1g-dev file wget zsh vim-gtk3 sudo

RUN useradd debuser -m -s "/bin/bash"
RUN usermod -aG sudo debuser


USER debuser

WORKDIR /home/debuser
RUN git clone https://git.openwrt.org/openwrt/openwrt.git
WORKDIR /home/debuser/openwrt

RUN ./scripts/feeds update -a
RUN ./scripts/feeds install -a

COPY --chown=debuser openwrt_config_linksys_e1200 .config

RUN make -j 10 defconfig download clean world

CMD ["/bin/bash"]
