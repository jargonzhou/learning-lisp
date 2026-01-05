(library (tspl printer)
  (export put-datum write display)
  (import 
    (except (rnrs) put-datum write display))

  (define lparen #\()
  (define rparen #\))
  (define non-print-chars
    '((#\alarm . "alarm")
      (#\backspace . "backsapce")
      (#\delete . "delete")
      (#\esc . "esc")
      (#\newline . "newline")
      (#\nul . "nul")
      (#\page . "page")
      (#\return . "return")
      (#\space . "space")
      (#\tab . "tab")
      (#\vtab . "vtab")))
  (define prompt "> ")

  (define (put-datum p x)
    (check-and-wr 'put-datum x #f p))

  (define write
    (case-lambda
      [(x) 
       (put-string (current-output-port) prompt) ; based: current-output-port
       (wr x #f (current-output-port))]
      [(x p)
       (put-string p prompt) 
       (check-and-wr 'write x #f p)]))
  
  (define display
    (case-lambda
    [(x)
     (put-string (current-output-port) prompt)
     (wr x #t (current-output-port))]
    [(x p)
     (put-string p prompt) 
     (check-and-wr 'display x #t p)]))
  
  ;;; helpers

  (define (check-and-wr who x d? p)
    (unless (and (output-port? p) (textual-port? p))
      (assertion-violation who "invalid argument" p))
    (wr x d? p))

  (define (wr x d? p) ; d? for display, p for port
    (cond
      [(symbol? x) 
       (put-string p (symbol->string x))           ; based: put-string
       (put-string p " : symbol")]                 ; add type hint   
      [(pair? x) 
       (wr-pair x d? p)
       (put-string p " : pair")]
      [(number? x) 
       (put-string p (number->string x))
       (put-string p " : number")]
      [(null? x) (put-string p "()")]
      [(boolean? x)
       (put-string p (if x "#t" "#f"))
       (put-string p " : boolean")]
      [(char? x) 
       (if d? (put-char p x) (wr-char x p))
       (put-string p " : char")]
      [(string? x)
       (if d? (put-string p x) (wr-string x p))
       (put-string p " : string")]
      [(vector? x)
       (wr-vector x d? p)
       (put-string p " : vector")]
      [(bytevector? x)
       (wr-bytevector x d? p)
       (put-string p " : bytevector")]
      [(eof-object? x) (put-string p "#<eof>")]
      [(port? x) (put-string p "#<port>")]
      [(procedure? x) (put-string p "#<procedure>")]
      [else (put-string p "#<unknown>")]))

  (define (wr-pair x d? p)
    (put-char p lparen)
    (let loop ([x x])
      (wr (car x) d? p)
      (cond
        [(pair? (cdr x)) (put-char p #\space) (loop (cdr x))]   ; based: put-char
        [(null? (cdr x))]
        [else (put-string p " . ") (wr (cdr x) d? p)]))
    (put-char p rparen))
  
  (define (wr-char x p)
    (put-string p "#\\")
    (cond
      [(assq x non-print-chars) => (lambda (a) (put-string p (cdr a)))]
      [else (put-char p x)]))
  
  (define (wr-string x p)
    (put-char p #\")
    (let ([n (string-length x)])
      (do ([i 0 (+ i 1)])
        ((= i n))
        (let ([c (string-ref x i)])
          (case c
            [(#\alarm) (put-string p "\\a")]
            [(#\backspace) (put-string p "\\b")]
            [(#\newline) (put-string p "\\n")]
            [(#\page) (put-string p "\\f")]
            [(#\return) (put-string p "\\r")]
            [(#\tab) (put-string p "\\t")]
            [(#\vtab) (put-string p "\\v")]
            [(#\") (put-string p "\\\"")]
            [(#\\) (put-string p "\\\\")]
            [else (put-char p c)]))))
    (put-char p #\"))
  
  (define (wr-vector x d? p)
    (put-char p #\#)
    (let ([n (vector-length x)])
      (do ([i 0 (+ i 1)]
           [sep lparen #\space])
        ((= i n))
        (put-char p sep)
        (wr (vector-ref x i) d? p)))
    (put-char p rparen))
  
  (define (wr-bytevector x d? p)
    (put-string p "#vu8")
    (let ([n (bytevector-length x)])
      (do ([i 0 (+ i 1)]
           [sep lparen #\space])
        ((= i n))
        (put-char p sep)
        (wr (bytevector-u8-ref x i) d? p)))
    (put-char p rparen))
)