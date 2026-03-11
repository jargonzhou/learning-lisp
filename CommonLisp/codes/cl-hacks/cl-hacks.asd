(in-package :asdf-user)

(defsystem "cl-hacks"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on (:cl-ppcre
               :alexandria
               :serapeum
               :ltk
               :defstar
               :closer-mop
               :fiveam)
  :components ((:module "src"
                        :components
                        ((:module "ansi-cl"
                                  :components
                                  ((:file "main")
                                   (:file "c01-introduction")
                                   (:file "c02-welcome-to-lisp")
                                   (:file "c03-lists")
                                   (:file "c04-specialized-data-structures")
                                   (:file "c05-control")
                                   (:file "c06-functions")
                                   (:file "c07-input-and-output")
                                   (:file "c08-symbols")
                                   (:file "c09-numbers")
                                   (:file "c10-macros")
                                   (:file "c11-clos")
                                   (:file "c12-structure")
                                   (:file "c13-speed")
                                   (:file "c14-advanced-topics")
                                   (:file "c15-example-inference")
                                   (:file "c16-example-generating-html")
                                   (:file "c17-example-objects")))
                         (:module "cl-cookbook"
                                  ; :depends-on (:cl-ppcre) ; NOT WORK
                                  :components
                                  ((:file "main")
                                   (:file "c09-variables")
                                   (:file "c10-functions")
                                   (:file "c11-data-structures")
                                   (:file "c12-strings")
                                   (:file "c13-numbers")
                                   (:file "c14-loops")
                                   (:file "c15-mdarrays")
                                   (:file "c16-date-time")
                                   (:file "c17-pattern-matching")
                                   (:file "c18-reg-expr")
                                   (:file "c19-io")
                                   (:file "c20-file-dir")
                                   (:file "c21-error")
                                   (:file "c22-packages")
                                   (:file "c23-macros")
                                   (:file "c24-clos")
                                   (:file "c25-type-system")
                                   (:file "c26-sockets")
                                   (:file "c27-os")
                                   (:file "c28-ffi")
                                   (:file "c29-dync-lib")
                                   (:file "c30-threads")
                                   (:file "c31-defining-systems")
                                   (:file "c32-debug")
                                   (:file "c33-perf")
                                   (:file "c34-scripting")
                                   (:file "c35-tests")
                                   (:file "c36-db")
                                   (:file "c37-gui")
                                   (:file "c38-web-dev")
                                   (:file "c39-web-scraping")
                                   (:file "c40-websockets")))
                         (:module "sbcl-hacks"
                                  :components
                                  ((:file "main")))
                         (:module "practical-cl"
                                  :components
                                  ((:file "main")
                                   (:file "c01-introduction-why-lisp")
                                   (:file "c02-lather-rinse-repeat-a-tour-of-the-repl")
                                   (:file "c03-practical-a-simple-database")
                                   (:file "c04-syntax-and-semantics")
                                   (:file "c05-functions")
                                   (:file "c06-variables")
                                   (:file "c07-macros-standard-control-constructs")
                                   (:file "c08-macros-defining-your-own")
                                   (:file "c09-practical-building-a-unit-test-framework")
                                   (:file "c10-numbers-characters-and-strings")
                                   (:file "c11-collections")
                                   (:file "c12-they-called-it-lisp-for-a-reason-list-processing")
                                   (:file "c13-beyond-lists-other-uses-for-cons-cells")
                                   (:file "c14-files-and-file-io")
                                   (:file "c15-practical-a-portable-pathname-library")
                                   (:file "c16-object-reorientation-generic-functions")
                                   (:file "c17-object-reorientation-classes")
                                   (:file "c18-a-few-format-recipes")
                                   (:file "c19-beyond-exception-handling-conditions-and-restarts")
                                   (:file "c20-the-special-operators")
                                   (:file "c21-programming-in-the-large-packages-and-symbols")
                                   (:file "c22-loop-for-black-belts")
                                   (:file "c23-practical-a-spam-filter")
                                   (:file "c24-practical-parsing-binary-files")
                                   (:file "c25-practical-an-id3-parser")
                                   (:file "c26-practical-web-programming-with-allegroserve")
                                   (:file "c27-practical-an-mp3-database")
                                   (:file "c28-practical-a-shoutcast-server")
                                   (:file "c29-practical-an-mp3-browser")
                                   (:file "c30-practical-an-html-generation-library-the-interpreter")
                                   (:file "c31-practical-an-html-generation-library-the-compiler")))
                         (:module "on-lisp"
                                  :components
                                  ((:file "main")
                                   (:module "utilities"
                                            :components
                                            ((:file "lists")
					     (:file "map")
					     (:file "io")
					     (:file "symstr")
					     (:file "macros")))
                                   (:file "c01-the-extensible-language")
                                   (:file "c02-functions")
                                   (:file "c03-functional-programming")
                                   (:file "c04-utility-functions")
                                   (:file "c05-returning-functions")
                                   (:file "c06-functions-as-representation")
                                   (:file "c07-macros")
                                   (:file "c08-when-to-use-macros")
                                   (:file "c09-variable-capture")
                                   (:file "c10-other-macro-pitfalls")
                                   (:file "c11-classic-macros")
                                   (:file "c12-generalized-variables")
                                   (:file "c13-computation-at-compile-time")
                                   (:file "c14-anaphoric-macros")
                                   (:file "c15-macros-returning-functions")
                                   (:file "c16-macro-defining-macros")
                                   (:file "c17-read-macros")
                                   (:file "c18-destructuring")
                                   (:file "c19-a-query-compiler")
                                   (:file "c20-continuations")
                                   (:file "c21-multiple-processes")
                                   (:file "c22-nondeterminism")
                                   (:file "c23-parsing-with-atns")
                                   (:file "c24-prolog")
                                   (:file "c25-object-oriented-lisp")))
                         (:module "let-over-lambda"
                                  :components
                                  ((:file "main")
                                   (:file "c1-introduction")
                                   (:file "c2-closures")
                                   (:file "c3-macro-basics")
                                   (:file "c4-read-macros")
                                   (:file "c5-programs-that-program")
                                   (:file "c6-anaphoric-macros")
                                   (:file "c7-macro-efficiency-topics")
                                   (:file "c8-lisp-moving-forth-moving-lisp")))
                         (:module "cl-recipes"
                                  :components
                                  ((:file "main")
                                   (:file "c01-symbols-and-packages")
                                   (:file "c02-conses-lists-and-trees")
                                   (:file "c03-strings-and-characters")
                                   (:file "c04-numbers-and-math")
                                   (:file "c05-arrays-and-vectors")
                                   (:file "c06-hash-tables-maps-and-sets")
                                   (:file "c07-sequences-and-iteration")
                                   (:file "c08-the-lisp-reader")
                                   (:file "c09-printing")
                                   (:file "c10-evaluation-compilation-control-flow")
                                   (:file "c11-concurrency")
                                   (:file "c12-error-handling-and-avoidance")
                                   (:file "c13-objects-classes-types")
                                   (:file "c14-io-streams-and-files")
                                   (:file "c15-pathnames-files-directories")
                                   (:file "c16-developing-and-debugging")
                                   (:file "c17-optimization")
                                   (:file "c18-libraries")
                                   (:file "c19-interfacing-with-other-languages"))))))
  :description ""
  :in-order-to ((test-op (test-op "cl-hacks/tests"))))

(defsystem "cl-hacks/tests"
  :author ""
  :license ""
  :depends-on ("cl-hacks"
               ;"rove"
               "fiveam")
  :components ((:module "tests"
                        :components
                        ((:file "main")
                         (:file "s-read-file-as-string")
                         (:module "on-lisp"
                                  :components
                                  ((:file "lists-test")))))
               (:module "src/cl-cookbook"
                        :components
                        ((:file "c35-tests"))))
  :description "Test system for cl-hacks"
  :perform (test-op (op c)
                    ;(symbol-call :rove :run c)
                    (progn
                     ;(symbol-call :fiveam :run! (find-symbol* :main-system :cl-hacks/tests/main))
                     (symbol-call :fiveam :run! (find-symbol* :on-lisp-suite :cl-hacks/tests/main))
                     ;(symbol-call :fiveam :run! (find-symbol* :my-system :cl-cookbook/c35-tests))
                     )))
