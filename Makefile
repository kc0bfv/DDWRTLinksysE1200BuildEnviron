build:
	sudo docker build -t ddwrt_e1200_build_environ .

interact:
	sudo docker run --rm -it ddwrt_e1200_build_environ:latest
