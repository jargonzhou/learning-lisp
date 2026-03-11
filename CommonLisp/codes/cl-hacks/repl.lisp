;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; REPL helper: slime-load-file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; load-asd
(asdf:load-asd (uiop:subpathname (uiop:getcwd) "cl-hacks.asd"))


;;; load dependencies
(ql:quickload "cl-ppcre")
(ql:quickload "alexandria")
(ql:quickload "serapeum")
(ql:quickload "ltk")
(ql:quickload "defstar")
(ql:quickload "trivial-backtrace")
(ql:quickload "closer-mop")
(ql:quickload "fiveam")
(ql:quickload "cffi")
(ql:quickload "bordeaux-threads")
(ql:quickload "lparallel")
(ql:quickload "mito")
(ql:quickload "log4cl")

;;; load hacks
(ql:quickload "cl-hacks")

;;; xref
;;; rm -rf tags && find . -type f -iname '*.lisp' | xargs ctags -a
#|
(defun gen-xref ()
  #+WIN32 (uiop:run-program "echo WIN32 && del /F tags" :output t)
  #+UNIX (uiop:run-program "echo UNIX" :output t))
(gen-xref)
|#
