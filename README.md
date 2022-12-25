# Purpose

This repo will setup a build environment in a container that will let you build for [dd-wrt](https://wiki.dd-wrt.com/wiki/index.php/Linksys_E1200v2) or [OpenWrt](https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem) running on a Linksys E1200 version 2.  Actually it'll probably work for any router running a Broadcom BCM47xx or BCM53xx MIPS Little Endian chip on those or similar firmwares.

# Prerequisites

Docker, sudo, make.

# Setup

`make` or `make build`

This generates a container tagged `ddwrt_e1200_build_environ:latest`.

# Use

GCC and other tools are stored in `/home/debuser/openwrt/staging_dir/toolchain-mipsel_mips32_gcc-11.3.0_musl/bin/`, and named `mipsel-openwrt-linux-gcc` and such.

Use these like any other binary in a container.

# Easy Use

Check out the `example_c_compilation` directory.  There's a makefile in there that you can copy and use elsewhere.  Drop it in a directory, change the `example.out` and `example.c` names, and go to town.

How that `CC` line works is - it uses `docker run` to:

* remove the container when it closes via `--rm`
* create an interactive and TTY environment via `-it`
* map the current directory in to `/tmp/hostdir` via the `-v` switch
* change into `/tmp/hostdir` via `-w`
* run the container you built
* runs the GCC binary inside that container

Other GCC command line parameters get stuck on after the `${CC}` in the example.out section.
