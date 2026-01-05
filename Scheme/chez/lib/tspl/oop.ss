(library (tspl oop)
  (export define-object send-message)
  (import (rnrs)
    ; (chezscheme) ; for trace  
  )
  

  ;;; Define abstract objects.
  ;;; usage:
  ;;; (define-object (name var1 ...)
  ;;;   ((var2 expr) ...)
  ;;;   ((msg action) ...))
  (define-syntax define-object
  ; (trace-define-syntax define-object
    (syntax-rules ()
      [(_ (name . varlist)
          ((var1 val1) ...)
          ((var2 val2) ...))
       (define name
         (lambda varlist
           (let* ([var1 val1] ...)
             (letrec ([var2 val2] ...)
               (lambda (msg . args)
                 (case msg
                   [(var2) (apply var2 args)]
                   ...
                   [else
                    (assertion-violation 'name "invalid message" (cons msg args))]))))))]
          
      [(_ (name . varlist) ((var2 val2) ...))
       (define-object (name . varlist)
         ()
         ((var2 val2) ...))]))
  
  (define-syntax send-message
    (syntax-rules ()
      [(_ obj msg arg ...)
       (obj 'msg arg ...)]))

)