# Akku
* https://akkuscm.org/

Akku.scm is a language package manager for Scheme. It grabs hold of code and shakes it vigorously until it behaves properly.
* One command to install everything needed for your project.
* Separately declare your dependencies and locked versions.
* Automatically convert R7RS libraries for use in R6RS projects.
* Audited build scripts for use with FFI libraries.
* Mirror of R7RS libraries from [Snow](http://snow-fort.org/).

```shell
# Windows WSL 2
➜  akku-1.1.0.amd64-linux ./install.sh
You can now run ~/.local/bin/akku
➜  akku-1.1.0.amd64-linux which akku
/usr/local/bin/akku
➜  akku-1.1.0.amd64-linux akku version
1.1.0
```

# Usage

```shell
$ akku init ex-project
$ cd ex-project
$ akku install

$ scheme
> (import (rnrs (6)) (ex-project))
> (hello "Akku")
"Hello Akku!"
```

find package:

ZX

```shell
$ akku list
```

install dependency:

ZX

```shell
$ akku add chez-srfi # writes Akku.manifest
$ akku lock          # writes Akku.lock
$ akku install       # updates .akku/
```

# See Also
