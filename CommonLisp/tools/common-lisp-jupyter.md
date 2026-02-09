# common-lisp-jupyter
* https://github.com/yitzchak/common-lisp-jupyter

> A Common Lisp kernel for Jupyter along with a library for building Jupyter kernels, based on [Maxima-Jupyter](https://github.com/robert-dodier/maxima-jupyter/) by Robert Dodier which was based on [cl-jupyter](https://github.com/fredokun/cl-jupyter/) by Frederic Peschanski.

# Setup

```lisp
* (ql:update-dist "quicklisp")
You already have the latest version of "quicklisp": 2026-01-01.
* (ql:quickload :common-lisp-jupyter)
; comment chacha in ironclad-vm: ~\quicklisp\dists\quicklisp\software\ironclad-v0.61\ironclad.asd
; MSYS2 zmq.h: pacman -S mingw-w64-x86_64-zeromq
; C:\Windows\System32\libzmq.dll: https://www.dllme.com/dll/files/libzmq
* (cl-jupyter:install)
Creating directories.
Installing kernel spec file C:/Users/zhouj/AppData/Roaming/jupyter/kernels/common-lisp/kernel.json
Installing kernel resources to C:/Users/zhouj/AppData/Roaming/jupyter/kernels/common-lisp/.
nil

(ql:uninstall "common-lisp-jupyter")
```

# Examples

- [common-lisp-jupyter.ipynb](./common-lisp-jupyter.ipynb)
