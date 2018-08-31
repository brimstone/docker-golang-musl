FROM golang:1.11

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/brimstone/docker-golang-musl" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1"

ENV TAR="" \
    VERBOSE="" \
    LDFLAGS="" \
    GOARCH="amd64" \
    GOOS="linux"

RUN apt-get update \
 && apt install -y build-essential \
    gcc-6-arm-linux-gnueabihf g++-6-arm-linux-gnueabihf mingw-w64 clang \
 && apt clean \
 && rm -rf /var/lib/apt/lists

RUN wget http://www.musl-libc.org/releases/musl-latest.tar.gz \
 && tar -zxvf musl-latest.tar.gz \
 && rm musl-latest.tar.gz \
 && cd musl* \
 && ./configure \
 && make -j$(nproc) \
 && make install \
 && rm -rf musl*

# Stolen from https://github.com/karalabe/xgo/blob/master/docker/base/Dockerfile
ENV OSX_SDK     MacOSX10.11.sdk
ENV OSX_NDK_X86 /usr/local/osx-ndk-x86
RUN OSX_SDK_PATH=https://s3.dockerproject.org/darwin/v2/$OSX_SDK.tar.xz \
 && wget $OSX_SDK_PATH \
 && git clone https://github.com/tpoechtrager/osxcross.git /osxcross \
 && mv `basename $OSX_SDK_PATH` /osxcross/tarballs/ \
 && sed -i -e 's|-march=native||g' /osxcross/build_clang.sh /osxcross/wrapper/build.sh \
 && UNATTENDED=yes OSX_VERSION_MIN=10.6 /osxcross/build.sh \
 && mv /osxcross/target $OSX_NDK_X86 \
 && rm -rf /osxcross

COPY loader /loader

WORKDIR /go/src/app

ENTRYPOINT [ "/loader" ]

ONBUILD ARG PACKAGE

ONBUILD COPY . /go/src/${PACKAGE}/

ONBUILD WORKDIR /go/src/${PACKAGE}/

ONBUILD RUN /loader -o /app
