FROM golang:1.6-alpine

RUN apk -U add gcc make git musl-dev

ENV TAR ""

ENV VERBOSE ""

ENV LDFLAGS ""

COPY loader /loader

ENTRYPOINT [ "/loader" ]
