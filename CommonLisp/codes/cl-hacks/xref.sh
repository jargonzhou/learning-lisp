#!/usr/bin/bash
rm -rf tags && find . -type f -name '*.lisp' | xargs ctags -a
