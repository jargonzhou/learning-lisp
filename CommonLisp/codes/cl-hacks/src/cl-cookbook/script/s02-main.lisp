#!/usr/local/bin/sbcl --script

(defun main ()
  :hello)

(eval-when (:execute)
  (main))
