(library (files)
  (export
    touch
    make-sure-file-exists
    make-sure-file-not-exists)
  (import
    (rnrs base)
    (rnrs files)
    (rnrs io simple))

  ;;; Touch file.
  (define (touch path)
    (call-with-output-file
      path
      (lambda (p)
        (display "touch ")
        (display path)
        (display " done")
        (newline))))

  ;;; Make sure file do exist.
  (define (make-sure-file-exists path)
    (if (file-exists? path)
      #t
      (touch path)))

  ;;; Make sure file not exist.
  (define (make-sure-file-not-exists path)
    (if (file-exists? path)
      (begin 
        (display "remove path: ")
        (display path)
        (newline)
        (delete-file path))
      #t))

)
