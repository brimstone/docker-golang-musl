golang-musl
===========

This is a container to build golang static binaries with musl instead of glibc.

Usage
-----

Check out your source files to a GOPATH compatible directory:

```bash
mkdir -p src/github.com/user
git clone https://github.com/user/repo.git src/github.com/user/repo
```

Then build!

```bash
docker run --rm -it -v "$PWD:/go" -u "$UID:$GID" brimstone/golang-musl github.com/user/repo
```

References
----------

http://dominik.honnef.co/posts/2015/06/statically_compiled_go_programs__always__even_with_cgo__using_musl/

