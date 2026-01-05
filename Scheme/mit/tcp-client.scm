(let ((sock (open-tcp-stream-socket "127.0.0.1" 8000)))
    (pp sock)
    (write-char #\h sock)
    (write-char #\newline sock)
    (flush-output-port sock) ; flush the socket buffer
    (let loop((lst `()) (c (read-char sock)))
            (if (char=? #\newline c) ;(eof-object? c)
                (begin
                    (close-port sock)
                    (display (list->string (reverse lst))))
                (loop (cons c lst) (read-char sock)))))