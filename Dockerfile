FROM golang:1.8-alpine

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/brimstone/docker-golang-musl" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1"

ENV TAR="" \
    VERBOSE="" \
    LDFLAGS=""

RUN apk -U add gcc make git musl-dev jq-dev

COPY loader /loader

ENTRYPOINT [ "/loader" ]
