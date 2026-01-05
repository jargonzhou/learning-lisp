;;; nil! set value to `()
(define-syntax nil!
    (syntax-rules ()
        ((_ x)          ; _ denote macro name
        (set! x `()))))

(define a 1)
(display a)
(newline)

(nil! a)
(display a)
(newline)

;;; when
(define-syntax when
    (syntax-rules ()
        ((_ pred b1 ...)
        (if pred (begin b1 ...)))))

(let ((x 10))
    (when (> x 5) (display (list x "is greater than" 5) )) (newline))


;;; demonstration of multiple patterns
(define-syntax incf!
    (syntax-rules ()
        ((_ x) (begin (set! x (+ x 1)) x))      ; pattern 1
        ((_ x i) (begin (set! x (+ x i)) x))))  ; pattern 2

(define b 2)
(begin
    (display (incf! b))
    (newline)
    (display (incf! b 2))
    (newline))