;;; VSCode commands
;;;
;;; Alive: Start REPL And Attach
;;; Alive: Detach from REPL

;;; Alive: Inline Eval
;;; Alive: Send To REPL
;;; Alive: Compile
(+ 2 2)

;;; Alive: Inline Eval
(defun hello-world ()
  "The Common Lisp HelloWorld"
  (format t "Hello, Common Lisp!!~%"))

;;; Alive: Inline Eval - Restarts
(defun divide (x y)
  (assert (not (zerop y))
      (y)
      "The second argument can not be zero.")
  (/ x y))
(divide 1 0)

;;; Alive: Macro Expand
(loop for x in '(a b c d e) do
        (print x))

;;; Alive: Disassemble
;;; (disassemble 'hello)
(defun hello (name)
  (format t "Hello, ~A~%" name))