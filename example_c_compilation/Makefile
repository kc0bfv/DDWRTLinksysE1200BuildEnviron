CONTAINER := ddwrt_e1200_build_environ:latest
CC := sudo docker run --rm -it -v "$(shell pwd)":/tmp/hostdir -w /tmp/hostdir -e STAGING_DIR=. ${CONTAINER} /home/debuser/openwrt/staging_dir/toolchain-mipsel_24kc_gcc-11.3.0_musl/bin/mipsel-openwrt-linux-gcc 

all: example.out

example.out: example.c
	${CC} $< -o $@ 
