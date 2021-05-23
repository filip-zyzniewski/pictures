FROM alpine:3.13.5

RUN apk add \
	firefox=88.0-r0 \
	make=4.3-r0 \
	ttf-dejavu  # Firefox has garbage UI without it

RUN mkdir /workdir
VOLUME /workdir
WORKDIR /workdir

ENTRYPOINT ["make"]
