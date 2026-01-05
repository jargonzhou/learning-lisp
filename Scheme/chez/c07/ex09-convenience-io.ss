(import (io simple) (files))

(define list-to-be-printed
  '((import (io simple)) (display "Hello, Scheme!") (newline) (exit)))

(comments "open-output-file")
; make sure file not exist
(make-sure-file-not-exists "myfile.ss")

(let ([p (open-output-file "myfile.ss")])
  (let f ([ls list-to-be-printed])
    (if (not (null? ls))
      (begin
        (write (car ls) p)
        (newline p)
        (f (cdr ls)))))
  (close-port p))

(comments "open-input-file")
(let ([p (open-input-file "myfile.ss")])
  (prs
    (let f ([x (read p)])
        (if (eof-object? x)
        (begin
            (close-port p)
            '())
        (cons x (f (read p)))))))

(comments "call-with-output-file")
; make sure file not exist
(make-sure-file-not-exists "myfile.ss")

(call-with-output-file "myfile.ss"
  (lambda (p)
    (let f ([ls list-to-be-printed])
      (unless (null? ls)
        (write (car ls) p)
        (newline p)
        (f (cdr ls))))))

(comments "call-with-input-file")
(call-with-input-file "myfile.ss"
  (lambda (p)
    (prs
      (let f ([x (read p)])
        (if (eof-object? x)
          '()
          (cons x (f (read p))))))))

(exit)