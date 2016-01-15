FROM golang:1.6beta2-wheezy

RUN wget http://www.musl-libc.org/releases/musl-latest.tar.gz \
 && tar -zxvf musl-latest.tar.gz \
 && rm musl-latest.tar.gz \
 && cd musl* \
 && ./configure \
 && make \
 && make install \
 && rm -rf musl*

ENV CC /usr/local/musl/bin/musl-gcc

ENTRYPOINT [ \
	"/usr/local/go/bin/go", \
	"build", \
	"-a", \
	"-installsuffix", \
	"cgo", \
	"-ldflags", \
	"-extldflags \"-static\"" \
	]
