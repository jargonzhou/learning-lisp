(defpackage :cl-cookbook/c27-os
  (:use #:cl
        #:log4cl))

(in-package :cl-cookbook/c27-os)

(log:info "cl-cookbook/c27-os")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; access environment variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(uiop:getenv "Path")
(uiop:getenv-absolute-directories "PATH")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; access command line arguments
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sb-ext:*posix-argv*

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; run external programs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; synchronously
(uiop:run-program "echo \"hello shell\"" :output t)
;;; asynchronously
(defparameter *shell*
              (uiop:launch-program "bash" :input :stream :output :stream))
(uiop:process-alive-p *shell*)

(write-line ;"find . -name '*.md'"
           "ls"
           (uiop:process-info-input *shell*))
(force-output (uiop:process-info-input *shell*))

;;; read single line
(read-line (uiop:process-info-output *shell*))
;;; drain output
(let ((stream (uiop:process-info-output *shell*)))
  (loop while (listen stream) do
          (princ (read-line stream))
          (terpri)))

(uiop:close-streams *shell*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; piping
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; or use trivial-features
(let ((cmd (if (member :win32 *features*)
               "dir"
               "ls")))
  (uiop:run-program "sort"
    :input
    (uiop:process-info-output
      (uiop:launch-program cmd :output :stream))
    :output :string))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; get Lisp's cuurent process ID
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(sb-posix:getpid)
