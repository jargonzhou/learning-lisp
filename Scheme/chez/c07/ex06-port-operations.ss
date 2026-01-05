(import (io simple))

(comments "call-with-port")
(call-with-port (open-file-input-port 
                  "LICENSE"
                  (file-options)
                  (buffer-mode block)
                  (native-transcoder))
  (lambda (ip)
    (call-with-port (open-file-output-port 
                      "outfile"
                      (file-options no-fail)
                      (buffer-mode block)
                      (native-transcoder))
      (lambda (op)
        (do ([c (get-char ip) (get-char ip)])
          ((eof-object? c))
          (put-char op c))))))

(exit)