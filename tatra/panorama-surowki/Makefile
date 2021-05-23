all: panorama.jpg

%.jpg: %.svg
	firefox -no-remote --screenshot $@ file://$(PWD)/$<

clean:
	rm -f panorama.jpg

.PHONY: clean
