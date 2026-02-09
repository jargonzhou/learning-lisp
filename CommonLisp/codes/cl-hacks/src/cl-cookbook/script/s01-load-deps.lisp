#!/usr/local/bin/sbcl --script

(require :uiop)
;;; to use quicklisp
(load "~/.sbclrc")

(ql:quickload "str" :silent t)
(princ (str:concat "hello " (uiop:getenv "USER") "!"))
