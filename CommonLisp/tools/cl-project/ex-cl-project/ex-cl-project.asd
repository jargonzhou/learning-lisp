(defsystem "ex-cl-project"
           :version "0.0.1"
           :author ""
           :license ""
           :depends-on ()
           :components ((:module "src"
                                 :components
                                 ((:file "main"))))
           :description ""
           :in-order-to ((test-op (test-op "ex-cl-project/tests"))))

(defsystem "ex-cl-project/tests"
           :author ""
           :license ""
           :depends-on ("ex-cl-project"
                        "rove")
           :components ((:module "tests"
                                 :components
                                 ((:file "main"))))
           :description "Test system for ex-cl-project"
           :perform (test-op (op c) (symbol-call :rove :run c)))
