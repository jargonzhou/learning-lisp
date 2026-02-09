(defpackage :cl-cookbook/c37-gui
  (:use #:cl
        #:ltk)
  (:import-from #:log4cl
                #:log))

(in-package :cl-cookbook/c37-gui)


(log:info "cl-cookbook/c37-gui")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Tk
;;; windows: https://github.com/teclabat/tcltk-binaries
;;;
;;; ltk: https://www.peter-herth.de/ltk/
;;;
;;; nodgui: https://github.com/lisp-mirror/nodgui
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(values
  *debug-tk*
  *wish-pathname*
  *wish-args*
  *ltk-version*)
;;; NIL
;;; wish
;;; (-name LTK)
;;; 0.993


;;; (with-ltk ()
;;;   (let ((button (make-instance 'button
;;;                   :text "hello"
;;;                   :command (lambda ()
;;;                              ; message box
;;;                              (do-msg "Hello World!")))))
;;;     (grid button 0 0)))


;;; run it manually
;;; (start-wish)
;;; enable event handling call
;;; (mainloop)
;;; (let ((button (make-instance 'button
;;;                 :text "Click Me"
;;;                 :command (lambda ()
;;;                            (do-msg "Clicked!")))))
;;;   (pack button))
;;; (exit-wish)
