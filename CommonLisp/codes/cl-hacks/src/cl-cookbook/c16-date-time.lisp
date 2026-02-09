(defpackage :cl-cookbook/c16-date-time
  (:use #:cl
        #:log4cl))

(in-package :cl-cookbook/c16-date-time)

(log:info "cl-cookbook/c16-date-time")

;;; universal time
;;; run time

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; built-in time functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; get-universal-time, decode-universal-time
;;; get-decodedtime


;;; internal-time-units-per-second
;;; get-internal-real-time, get-internal-run-time
;;; time

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; lib: local-time
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; encode-timestamp
;;; universal-to-timestamp
;;; parse-timestring
;;; now, today
;;; timestamp+, timestamp-
;;; adjust-timestamp

;;; timestamp<, timestamp>, timestamp=, ...

;;; timestamp-minimum, timestamp-maximum
;;; timestamp-maximize-part

;;; timestamp-year, ...
;;; with-decoded-timestamp

;;; format-timestring
;;; unix-to-timestamp

;;; parse-timestring
