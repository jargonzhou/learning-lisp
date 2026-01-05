(define (read-file file-name)
    ;;; read conent of file
    (let ((p (open-input-file file-name)))
        (let loop((lst `()) (c (read-char p)))
            (if (eof-object? c)
                (begin
                    (close-input-port p)
                    (list->string (reverse lst)))
                (loop (cons c lst) (read-char p))))))

; (let ((content (read-file "io.scm")))
;     (display content))

(define (read-file2 file-name)
    (call-with-input-file file-name
        (lambda (p) ; parameter: port
            (let loop((lst `()) (c (read-char p)))
                (if (eof-object? c)
                    (begin (close-input-port p) (list->string (reverse lst)))
                    (loop (cons c lst) (read-char p)))))))
; (let ((content (read-file2 "io.scm")))
;    (display content))

(define (read-file3 file-name)
    (with-input-from-file file-name
        (lambda ()  ; no parameter
            (let loop((lst `()) (c (read-char)))
                (if (eof-object? c)
                    (list->string (reverse lst))
                    (loop (cons c lst) (read-char)))))))

; (let ((content (read-file3 "io.scm")))
;    (display content))                    

(define (s-read file-name)
    ;;; read s-expression from file
    (with-input-from-file file-name
        (lambda () 
            (let loop((lst `()) (s (read)))
                (if (eof-object? s)
                    (reverse lst)
                    (loop (cons s lst) (read)))))))
(let ((lst (s-read "paran.txt")))
    (display lst))