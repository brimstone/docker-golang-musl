FROM golang:1.6.0-alpine

RUN apk -U add gcc make git musl-dev

ENV TAR ""

ENV VERBOSE ""

COPY loader /loader

ENTRYPOINT [ "/loader" ]
