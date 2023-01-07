# Purpose

This repo will setup a build environment in a container that will let you build binaries for [dd-wrt](https://wiki.dd-wrt.com/wiki/index.php/Linksys_E1200v2) or [OpenWrt](https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem) running on a Linksys E1200 version 2.  Actually it'll probably work for any router running a Broadcom BCM47xx or BCM53xx MIPS Little Endian chip on those or similar firmwares.

Additionally, it will compile an OpenWrt image that can run in Qemu that will allow you to test your binaries. 

# Prerequisites

Docker, sudo, make.

Optionally: qemu-system-mips (for running the OpenWrt image).

# Setup

`make` or `make build`

This generates a container tagged `ddwrt_e1200_build_environ:latest`.

# Build Tool Use

GCC and other tools are stored in `/home/debuser/openwrt/staging_dir/toolchain-mipsel_24kc_gcc-11.3.0_musl/bin/`, and named `mipsel-openwrt-linux-gcc` and such.  Use these like any other binary in a container.

## Easy Use

Check out the `example_c_compilation` directory.  There's a makefile in there that you can copy and use elsewhere.  Drop it in a directory, change the `example.out` and `example.c` names, and go to town.

How that `CC` line works is - it uses `docker run` to:

* remove the container when it closes via `--rm`
* create an interactive and TTY environment via `-it`
* map the current directory in to `/tmp/hostdir` via the `-v` switch
* change into `/tmp/hostdir` via `-w`
* run the container you built
* runs the GCC binary inside that container

Other GCC command line parameters get stuck on after the `${CC}` in the example.out section.

# OpenWrt Qemu Use

The [OpenWrt instructions are here](https://openwrt.org/docs/guide-user/virtualization/qemu#openwrt_in_qemu_mips), and the files you need are in the image at `/home/debuser/openwrt/bin/targets/malta/le/`.

In short, you'll need:

* `openwrt-snapshot-malta-le-vmlinux.elf`
* `openwrt-snapshot-malta-le-rootfs-ext4.img.gz`

You can pull those out by running:

```sh
sudo docker run --rm -it -d ddwrt_e1200_build_environ
sudo docker cp $ID_FROM_DOCKER:/home/debuser/openwrt/bin/targets/malta/le/$FILENAME...
sudo docker stop $ID_FROM_DOCKER
```

You'll need to `gzip -d` the rootfs.

Then:

```sh
sudo qemu-system-mipsel -M malta \
-hda openwrt-snapshot-malta-le-rootfs-ext4.img \
-kernel openwrt-snapshot-malta-le-vmlinux.elf \
-nographic -append "root=/dev/sda console=ttyS0" \
-nic tap
```

This will add a `tap` network device to your host, connected to `br-lan` in Qemu.  That defaults to `192.168.1.1/24`, so if you run the following in your host you'll be able to connect to the router there:

`sudo ip addr add dev tap0 192.168.1.10/24`

Note that if you have more than one tap device you may need to change the tap number.
