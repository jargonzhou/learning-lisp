;(unintern 'SWANK::WITHOUT-SLIME-INTERRUPTS (find-package "SWANK"))
;(unintern 'SWANK/BACKEND::WITHOUT-SLIME-INTERRUPTS (find-package "SWANK")) ; if necessary

(ql:quickload '("swank" "bordeaux-threads"))

(require :swank)
(require :bordeaux-threads)

(defparameter *counter* 0)

(defun dostuff ()
  (format t "hello world ~a!~&" *counter*))

(defun runner ()
  (swank:create-server :port 4007 :dont-close t)
  (format t "we are past go!~&")
  (bt:make-thread (lambda ()
		    (loop repeat 5 do
			  (sleep 5)
			  (dostuff)
			  (incf *counter*)))
		  :name "do-stuff"))

(runner)
