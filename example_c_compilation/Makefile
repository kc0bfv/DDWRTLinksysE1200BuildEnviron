CONTAINER := ddwrt_e1200_build_environ:latest
CC := sudo docker run --rm -it -v "$(shell pwd)":/tmp/hostdir -w /tmp/hostdir ${CONTAINER} /home/debuser/openwrt/staging_dir/toolchain-mipsel_mips32_gcc-11.3.0_musl/bin/mipsel-openwrt-linux-gcc 

all: example.out

example.out: example.c
	${CC} $< -o $@ 
