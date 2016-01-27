FROM golang:1.6beta2-alpine

RUN apk -U add gcc make git musl-dev

COPY loader /loader

ENTRYPOINT [ "/loader" ]
