(library (tspl wfreq)
  (export frequence)
  (import 
    (except (rnrs) standard-output-port)
    (only (chezscheme) standard-output-port))
  
  ;;; Get next word in port.
  (define (get-word p)        ; p for port
    (let ([c (get-char p)])
      (if (eq? (char-type c) 'letter)
        (list->string
          (let loop ([c c])
            (cons
              c
              (if (memq (char-type (lookahead-char p)) '(letter digit))
                (loop (get-char p))
                '()))))
        c)))
  
  ;;; Get type of a character.
  (define (char-type c)
    (cond
      [(eof-object? c) c]
      [(char-alphabetic? c) 'letter]
      [(char-numeric? c) 'digit]
      [else c]))

  (define-record-type tnode
    (fields (immutable word)
            (mutable left)
            (mutable right)
            (mutable count))
    ; constructor
    (protocol
      (lambda (new)
        (lambda (word)
          (new word '() '() 1)))))

    ;;; Add a word at tree node.
    (define (add-word node word)
      (cond
        [(null? node) (make-tnode word)]
        [(string=? word (tnode-word node))
         (tnode-count-set! node (+ (tnode-count node) 1))
         node]
        [(string<? word (tnode-word node))
         (tnode-left-set! node (add-word (tnode-left node) word))
         node]
        [else
         (tnode-right-set! node (add-word (tnode-right node) word))
         node]))

  (define (tree-print node p)
    (unless (null? node)
      (tree-print (tnode-left node) p)
      (put-datum p (tnode-count node))
      (put-char p #\space)
      (put-string p (tnode-word node))
      (newline p)
      (tree-print (tnode-right node) p)))
 
  (define (frequence infn . outfn) ; in file name, out file name
    (let ([inp (open-file-input-port infn (file-options)
                 (buffer-mode block) (native-transcoder))]
          [outp (if (null? outfn)
                  (standard-output-port 
                    (buffer-mode block) (native-transcoder))
                  ; replace: CS9 Section 9.2. File Options
                  (open-file-output-port (car outfn) (file-options replace)
                    (buffer-mode block) (native-transcoder)))])
      (do-frequence inp outp)))
  
  (define (do-frequence inp outp)
    (let loop ([root '()])
        (let ([w (get-word inp)])
          (cond
            [(eof-object? w) (tree-print root outp)]
            [(string? w) (loop (add-word root w))]
            [else (loop root)])))
      (close-port inp)
      (close-port outp))

)