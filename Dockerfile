FROM golang:1.6-alpine

ENV TAR="" \
    VERBOSE="" \
    LDFLAGS=""

RUN apk -U add gcc make git musl-dev

COPY loader /loader

ENTRYPOINT [ "/loader" ]
