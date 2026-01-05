(import 
  (io simple)
  (chezscheme))

(comments "current-output-port")
(let ([p (current-output-port)])
  (write "Hello, Scheme!" p)
  (newline p))

(comments "standard-output-port")
(let ([p (standard-output-port (buffer-mode block) (native-transcoder))])
  (write "Hello, Scheme!" p)
  (newline p))

(exit)