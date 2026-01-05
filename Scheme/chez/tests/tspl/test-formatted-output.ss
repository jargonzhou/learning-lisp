(import (tspl formatted-output)
        (io simple)
        (rnrs))

; format directives: ~s, ~a, ~%, ~~

(printf "The string ~s display as ~~.~%" "~")
(fprintf (current-output-port) "~s ~a ~%" 1 "word")

(exit)