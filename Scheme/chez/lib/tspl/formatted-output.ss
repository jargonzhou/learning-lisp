(library (tspl formatted-output)
  (export printf fprintf)
  (import (rnrs))

  ; p for port
  ; cntl for control string
  (define (dofmt p cntl args)
    (let ([nmax (- (string-length cntl) 1)])
      (let loop ([n 0] [arg args])
        (if (<= n nmax)
          (let ([c (string-ref cntl n)])
            (if (and (char=? c #\~) (< n nmax)) ; encounter directives
              (case (string-ref cntl (+ n 1))
                [(#\a #\A)                      ; ~a: display
                 (display (car arg) p) (loop (+ n 2) (cdr arg))]
                [(#\s #\S)                      ; ~s: write
                 (write (car arg) p) (loop (+ n 2) (cdr arg))]
                [(#\%)                          ; ~%: newline
                 (newline p) (loop (+ n 2) arg)]
                [(#\~)                          ; ~~: tilde(~)
                 (put-char p #\~) (loop (+ n 2) arg)]
                [else                           ; ~ with others
                 (put-char p c) (loop (+ n 1) arg)])
              (begin
                (put-char p c)
                (loop (+ n 1) arg))))))))  
  
  (define (printf control . args)
    (dofmt (current-output-port) control args))

  (define (fprintf p control . args)
    (dofmt p control args))

)