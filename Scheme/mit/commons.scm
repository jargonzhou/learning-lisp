(define (println obj)
    ;;; pretty print object
    (pp obj) 
    (newline))

(define (println2 obj desc)
    (display desc)
    (pp obj)
    (newline))