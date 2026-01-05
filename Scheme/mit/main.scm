(load "worker.scm")

(define (print . args)
    (for-each display args)
    (newline) )

(define (main argv)
    (let ( (w (make-worker 0)) )
        (print "worker: " (w))
        (print "worker: " (w))
        (print "worker: " (w)) ) )

(main 1)
;(%exit 0) ;; drops into repl otherwise