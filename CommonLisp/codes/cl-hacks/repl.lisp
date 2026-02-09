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
(ql:quickload "closer-mop")
(ql:quickload "fiveam")
(ql:quickload "cffi")
(ql:quickload "bordeaux-threads")
(ql:quickload "lparallel")
(ql:quickload "mito")
(ql:quickload :log4cl)

;;; load hacks
(ql:quickload "cl-hacks")
