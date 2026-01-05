(import (io simple))

(comments "buffer-mode, buffer-mode?")
(prs
  (buffer-mode block)
  ; (buffer-mode cushion) ; invalid buffer mode cushion

  (buffer-mode? 'block)
  (buffer-mode? 'line)
  (buffer-mode? 'none)
  (buffer-mode? 'something-else)
)

(exit)