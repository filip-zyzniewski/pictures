export HOME=$(shell pwd)/tmphome

all: panorama.jpg


%.jpg: %.xml image-legend.xsl
	firefox --headless -no-remote -CreateProfile profile
	echo 'user_pref("privacy.file_unique_origin", false);' >> `echo $(HOME)/.mozilla/firefox/*.profile/ `user.js
	firefox -P profile -no-remote --screenshot $@ file://`pwd`/$<
	# Firefox seems to be doing 0600
	chmod 0644 $@
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
