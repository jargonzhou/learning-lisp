(import (io simple))

; example from Guile 6.12.10.4 Custom Ports
; url: https://www.gnu.org/software/guile/manual/html_node/Custom-Ports.html
(comments "make-custom-binary-input-port")
(let ()
  (define (open-bytevector-input-port source)
    (define position 0)
    (define length (bytevector-length source))

    (define (read! bv start count)
      (let ((count (min count (- length position))))
        (bytevector-copy! source position
                          bv start count)
        (set! position (+ position count))
        count))

    (define (get-position) position)

    (define (set-position! new-position)
      (set! position new-position))

    (make-custom-binary-input-port 
      "the port" 
      read!
      get-position 
      set-position!
      #f))
  
  (let ([p (open-bytevector-input-port (string->utf8 "hello"))])
    (prs 
      (utf8->string (get-bytevector-n p 5)))))

(exit)