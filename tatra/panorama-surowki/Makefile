export HOME=$(shell pwd)/tmphome

all: panorama.jpg

%.jpg: %.svg
	firefox --headless -CreateProfile profile
	firefox -no-remote --screenshot $@ file://`pwd`/$<
	rm -r `pwd`/tmphome

clean:
	rm -f panorama.jpg

containerized:
	docker build -t panorama-build .
	docker run \
	--rm \
	--interactive \
	--tty \
	--user `id -u`:`id -g` \
	--volume $(PWD):/workdir \
	panorama-build

.PHONY: clean containerized
