(library (tools tests)
    (export *test-enabled?* run-tests run-test)
    (import (rnrs))
    
    ;;; Configuration
    (define *test-enabled?* #t)

    ;;; TODO: add assert procedures.

    ;;; run tests
    ;;;
    ;;; f: to validated procedure
    ;;; datas: procedure arguments, in list
    (define (run-tests f datas)
        (if *test-enabled?*
            (do-run-tests f datas)
            '()))

    (define (do-run-tests f datas)
        (display "run test ")
        (display f)
        (newline)
        (if (and (not (null? datas)) (list? datas))
            (let f-arg ([ds datas])
                (if (null? ds)
                    (begin (display "done!") (newline) (newline))
                    (begin 
                        (display " arg: ") 
                        (display (car ds))
                        (display ", result: ")
                        (display (f (car ds)))
                        (display ".")
                        (newline)
                        (f-arg (cdr ds)))))
            (begin (display "invalid input: ") (display datas))))

    ;;; run a test
    ;;;
    ;;; f: to validated procedure
    ;;; arg: procedure arguments, may be none or multiple
    (define (run-test f . arg)
        (if *test-enabled?*
            (apply do-run-test f arg)
            '()))

    (define (do-run-test f . arg)
        (display "run test ")
        (display f)
        (newline)
        (display " arg: ")
        (display arg)
        (display ", result: ")
        (display (apply f arg)) ; using apply
        (display ".")
        (newline)
        (display "done!")
        (newline)
        (newline)))
